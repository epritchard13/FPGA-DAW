#pragma once

#include <vector>
#include <string>
#include <iostream>

/**
 * NOTE: Timestamps are measured in samples.
 */
class Clip {
public:
	uint data;			// address of audio data in storage. This is NOT a c++ pointer.
	uint size;
	uint timestamp;		
	friend std::ostream& operator<< (std::ostream &os, const Clip &s);
};

class Track {
public:
	std::vector<Clip> clips;
	friend std::ostream& operator<< (std::ostream &os, const Track &s);
};

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