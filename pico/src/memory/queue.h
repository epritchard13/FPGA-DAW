#include <queue>
#include <vector>
#include "pico/stdlib.h"

#include "mem.h"

#define MAX_QUEUE_SIZE 32

struct segment_t {
    uint start; //offset from start of audio clip // TODO: can these be smaller?
    uint size; //segment size
    uint complete_size;
    std::vector<block_t> blocks;

    inline constexpr uint start_absolute(uint timestamp) {
        return timestamp + start;
    }
    inline constexpr uint end_absolute(uint timestamp) {
        return timestamp + start + size;
    }
    inline constexpr uint max_end_absolute(uint timestamp) {
        return timestamp + start + complete_size;
    }
};

struct mem_op_t {
    storage_ptr_t data;     // The storage address of the segment start.
    segment_t* seg;         // The segment to add the allocated block to
};

struct MemQueue { // TODO: make class
    std::queue<mem_op_t> operations;
    Memory mem;

public:
    //MemQueue();
    void push(mem_op_t op);
    void pop();
    bool full();
    bool empty();
    void clear();
};