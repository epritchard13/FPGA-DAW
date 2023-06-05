#include "player.h"
#include <sstream>
#include <algorithm>
#include "memory/mem.h"

#include "json.h"

void Player::player_sm() {
    static int current_track;
    static uint virtualHeadPos;

    switch (state) {
    case DONE:
        // Do nothing.
        break;
    case MOVED:
        state = LOADING;
        virtualHeadPos = headPos;
        current_track = 0;
        queue.clear();

        //find current clips
        for (int i = 0; i < tracks.size(); i++) {
            tracks[i].current_clip = -1;
            for (int j = 0; j < tracks[i].clips.size(); j++) {
                if (tracks[i].clips[j].end() > headPos) { //if clips ends in the future
                    tracks[i].current_clip = j; // this is the clip we'll focus on first
                    break;
                }
            }
        }

        //look through clip segments
        for (int i = 0; i < tracks.size(); i++) {
            if (tracks[i].current_clip == -1)
                continue;
            
            Clip& clip = tracks[i].clips[tracks[i].current_clip];

            // some temp code
            clip.segments = std::vector<segment_t>();

            // add a segment that runs from the head to the end of the clip
            uint offset = headPos - clip.timestamp;
            clip.segments.push_back({offset, 0, clip.size - offset});
            clip.current_segment = 0;

            //for (int j = 0; j < clip.segments.size(); j++) {
            //}

        }


        break;
    case LOADING:
        if (queue.full())
            break;
        if (current_track >= tracks.size()) {
            current_track = 0;
            virtualHeadPos += BLOCK_SIZE;
        }

        //printf("Loading, virtual headpos: %d, current track: %d\n", virtualHeadPos, current_track);

        // find out if the current segment is over
        Clip& curr = tracks[current_track].clips[tracks[current_track].current_clip];
        segment_t& seg = curr.segments[curr.current_segment];

        if (virtualHeadPos >= curr.timestamp + seg.start + seg.complete_size) {
            // The head position is past the end of the current segment

        } else if (virtualHeadPos < curr.timestamp + seg.start) {
            // The head position is before the start of the current segment
        } else {
            // we can add another block
            //uint block_size = std::min((uint) BLOCK_SIZE, );
            //printf("%d\n", seg.complete_size - BLOCK_SIZE * seg.blocks.size());
            queue.push({curr.data + (virtualHeadPos - curr.timestamp), &seg});
        }

        current_track++;
        break;
    }
}

bool Player::movePlayhead(uint newPos) {
    headPos = newPos;
    state = MOVED;
    return true;
}

bool Player::addClip(uint track, uint data, uint timestamp, uint size) {
    if (track >= tracks.size()) {
        //std::cout << "track " << track << " does not exist" << std::endl;
        return false;
    }
    this->tracks[track].clips.push_back({data, size, timestamp});

    // sort clips by timestamp
    std::sort(this->tracks[track].clips.begin(), this->tracks[track].clips.end(), [](const Clip& a, const Clip& b) {
        return a.timestamp < b.timestamp;
    });

    return true;
}

// String functions used for testing
std::ostream& operator<< (std::ostream &os, const Clip &s) {
    std::stringstream ss;
    ss << '[';
    std::vector<segment_t> vec = s.segments;
    for (segment_t seg : vec) {
        ss << "(" << seg.start << " " << seg.size << " " << seg.complete_size << ")";
    }
    ss << ']';

    os << "Clip(" << s.data << ", " << s.timestamp << ", " << s.size << ", " << s.current_segment << ", " << ss.str() << ")";
    return os;
}

std::ostream& operator<< (std::ostream &os, const Track &s) {
    os << "Track(";
    for (int i = 0; i < s.clips.size(); i++) {
        os << s.clips[i];
        if (i != s.clips.size() - 1)
            os << ", ";
    }
    os << ")";
    return os;
}

std::ostream& operator<< (std::ostream &os, const Player &s) {
    os << "Player(" << s.headPos << ", ";
    for (int i = 0; i < s.tracks.size(); i++) {
        os << s.tracks[i];
        if (i != s.tracks.size() - 1)
            os << ", ";
    }
    os << ")";
    return os;
}

std::string Player::toJson() {
    json::jobject top;
    top["head_pos"] = headPos;

    std::vector<json::jobject> track_arr;
    
    for (int i = 0; i < tracks.size(); i++) {
        json::jobject track;
        std::vector<json::jobject> clip_arr;

        for (int j = 0; j < tracks[i].clips.size(); j++) {
            json::jobject clip;
            std::vector<json::jobject> segment_arr;

            for (int k = 0; k < tracks[i].clips[j].segments.size(); k++) {
                json::jobject segment;
                segment["start"] = tracks[i].clips[j].segments[k].start;
                segment["size"] = tracks[i].clips[j].segments[k].size;
                segment["complete_size"] = tracks[i].clips[j].segments[k].complete_size;

                std::vector<int> block_arr;
                for (int l = 0; l < tracks[i].clips[j].segments[k].blocks.size(); l++) {
                    block_arr.push_back(tracks[i].clips[j].segments[k].blocks[l]);
                }

                segment["blocks"] = block_arr;
                segment_arr.push_back(segment);
            }

            clip["data"] = tracks[i].clips[j].data;
            clip["timestamp"] = tracks[i].clips[j].timestamp;
            clip["size"] = tracks[i].clips[j].size;
            clip["current_segment"] = tracks[i].clips[j].current_segment;
            clip["segments"] = segment_arr;
            clip_arr.push_back(clip);
        }

        track["clips"] = clip_arr;
        track_arr.push_back(track);
    }
    
    top["tracks"] = track_arr;

    top["num_mem_blocks"] = NUM_BLOCKS;
    top["mem_blocks"] = queue.mem.getBlocks();

    return (std::string) top;
}