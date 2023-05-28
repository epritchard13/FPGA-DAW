#pragma once

#include <vector>

class Clip {
public:
	void* data;			// pointer to audio data
	uint size;			// in samples
	uint timestamp;		// in samples
};

class Track {
public:
	std::vector<Clip> clips;
};

class Player {
public:
	uint head_pos;
	std::vector<Track> tracks;
};