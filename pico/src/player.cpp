#include "player.h"

bool Player::add_clip(uint track, uint data, uint size, uint timestamp) {
    if (track >= tracks.size()) {
        //std::cout << "track " << track << " does not exist" << std::endl;
        return false;
    }
    this->tracks[track].clips.push_back({data, size, timestamp});
    return true;
}

// String functions used for testing
std::ostream& operator<< (std::ostream &os, const Clip &s) {
    os << "Clip(" << s.data << ", " << s.size << ", " << s.timestamp << ")";
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
    os << "Player(" << s.head_pos << ", ";
    for (int i = 0; i < s.tracks.size(); i++) {
        os << s.tracks[i];
        if (i != s.tracks.size() - 1)
            os << ", ";
    }
    os << ")";
    return os;
}