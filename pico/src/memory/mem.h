#pragma once

#include <unordered_set>
#include "pico/stdlib.h"

typedef uint16_t block;

#define MEMORY_SIZE (8*1024*1024) // 8MB PSRAM
#define BLOCK_SIZE (16*1024) // 16KB blocks
#define NUM_BLOCKS (MEMORY_SIZE / BLOCK_SIZE) // 512 blocks

#define MEM_ERROR 0xffff // TODO: not sure if this will be used

class Memory {
    std::unordered_set<block> freeBlocks;

public:
    Memory();
    block alloc();
    void free(block b);
};

