#include "player.h"
#include "../fatfs/ff.h"

#include <vector>

class Project {
public:
    Project();
    ~Project();

    std::vector<Track> tracks;
    std::vector<FIL*> files;

    void load_project();
    void save_project();

    void add_clip(int track_id, Clip clip);
};