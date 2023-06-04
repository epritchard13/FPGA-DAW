#pragma once

#include <unordered_set>
#include <iostream>
#include "pico/stdlib.h"

#define MEMORY_SIZE 8192 //(8*1024*1024) // 8MB PSRAM
#define BLOCK_SIZE 64 //(16*1024) // 16KB blocks
#define NUM_BLOCKS (MEMORY_SIZE / BLOCK_SIZE) // 512 blocks

typedef uint16_t block_t; // The ID number of a block of memory.
typedef uint storage_ptr_t; // The address of some audio in storage.

#define MEM_ERROR 0xffff // TODO: not sure if this will be used

class Memory {
    std::unordered_set<block_t> freeBlocks;

public:
    Memory();
    block_t alloc();
    void free(block_t b);



    friend std::ostream& operator<< (std::ostream &os, const Memory &m);
};

