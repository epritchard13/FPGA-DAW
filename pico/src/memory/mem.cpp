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

std::ostream& operator<< (std::ostream &os, const Memory &m) {
    //print every free block
    os << NUM_BLOCKS << " ";
    for (auto it = m.freeBlocks.begin(); it != m.freeBlocks.end(); it++) {
        os << *it << " ";
    }
    return os;
}