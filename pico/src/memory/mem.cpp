#include "mem.h"


Memory::Memory() {
    for (int i = 0; i < NUM_BLOCKS; i++) {
        freeBlocks.insert(i);
    }
}

block Memory::alloc() {
    if (freeBlocks.size() == 0) {
        return MEM_ERROR;
    }
    block b = *freeBlocks.begin();
    freeBlocks.erase(b);
    return b;
}

void Memory::free(block b) {
    freeBlocks.insert(b);
}
