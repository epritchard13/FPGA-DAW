#pragma once

#include <vector>
#include <string>
#include <iostream>
#include "../memory/queue.h"
#include "../fatfs/ff.h"

/**
 * @brief Stores information about an audio clip.
 * 
 * NOTE: Timestamps are measured in samples.
 */
struct Clip {
	storage_ptr_t data;
	//FIL* file;				// The file associated with this clip
	//uint offset;				// The offset into the file where the clip starts
	uint timestamp;				// start time of the clip
	uint size;
	inline constexpr uint end() const { return timestamp + size; }

	uint current_segment;
	std::vector<segment_t> segments;	// The segments of contiguous blocks stored in memory

	void add_segment(segment_t seg);

	friend std::ostream& operator<< (std::ostream &os, const Clip &s);
};

/**
 * @brief Stores a list of audio clips.
 * 
 */
struct Track {
	int current_clip;
	std::vector<Clip> clips;

	friend std::ostream& operator<< (std::ostream &os, const Track &s);
};

/**
 * @brief Stores a list of tracks, which in turn each store a list of clips.
 * 
 */
struct Player { //TODO: make class
	uint headPos = 0;
	MemQueue queue;

	enum {
		DONE,		// Loading is complete.
		MOVED,		// The playhead has moved. Rerun the state machine.
		LOADING		// Loading is in progress.
	} state = MOVED;

public:
	std::vector<Track> tracks;
	void player_sm();
	bool movePlayhead(uint new_pos);
	std::string toJson();

	/**
	 * Shortcut function used for debugging
	 */
	bool addClip(uint track, uint data, uint size, uint timestamp);

	friend std::ostream& operator<< (std::ostream &os, const Player &s);
};
