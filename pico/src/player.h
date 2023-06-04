#pragma once

#include <vector>
#include <string>
#include <iostream>
#include "memory/queue.h"

/**
 * @brief Stores information about an audio clip.
 * 
 * NOTE: Timestamps are measured in samples.
 */
struct Clip {
	storage_ptr_t data;			// address of audio data in storage. This is NOT a c++ pointer.
	uint size;
	uint timestamp;
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
class Player {
	uint head_pos = 200;
	MemQueue queue;

	enum {
		DONE,		// Loading is complete.
		MOVED,		// The playhead has moved. Rerun the state machine.
		LOADING		// Loading is in progress.
	} state = MOVED;

public:
	std::vector<Track> tracks;
	void player_sm();

	/**
	 * Shortcut function used for debugging
	 */
	bool add_clip(uint track, uint data, uint size, uint timestamp);

	friend std::ostream& operator<< (std::ostream &os, const Player &s);
};
