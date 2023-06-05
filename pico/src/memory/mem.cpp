#include "mem.h"


Memory::Memory() {
    for (int i = 0; i < NUM_BLOCKS; i++) {
        freeBlocks.insert(i);
    }
}

block_t Memory::alloc() {
    if (freeBlocks.size() == 0) {
        return MEM_ERROR;
    }
    block_t b = *freeBlocks.begin();
    freeBlocks.erase(b);
    return b;
}

void Memory::free(block_t b) {
    freeBlocks.insert(b);
}

std::vector<int> Memory::getBlocks() { 
    std::vector<int> blocks;
    for (auto it = freeBlocks.begin(); it != freeBlocks.end(); it++) {
        blocks.push_back(*it);
    }
    return blocks;
}
