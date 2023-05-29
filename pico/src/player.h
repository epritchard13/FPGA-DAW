#pragma once

#include <vector>
#include <string>
#include <iostream>

/**
 * @brief Stores information about an audio clip.
 * 
 * NOTE: Timestamps are measured in samples.
 */
class Clip {
public:
	uint data;			// address of audio data in storage. This is NOT a c++ pointer.
	uint size;
	uint timestamp;		

	// More information will be added here...

	friend std::ostream& operator<< (std::ostream &os, const Clip &s);
};

/**
 * @brief Stores a list of audio clips.
 * 
 */
class Track {
public:
	std::vector<Clip> clips;
	friend std::ostream& operator<< (std::ostream &os, const Track &s);
};

/**
 * @brief Stores a list of tracks, which in turn each store a list of clips.
 * 
 */
class Player {
public:
	uint head_pos;
	std::vector<Track> tracks;
	friend std::ostream& operator<< (std::ostream &os, const Player &s);

	/**
	 * Shortcut function used for debugging
	 */
	bool add_clip(uint track, uint data, uint size, uint timestamp);
};