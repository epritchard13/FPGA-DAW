#include <queue>
#include <vector>
#include "pico/stdlib.h"

#include "mem.h"

struct segment {
    uint start; // TODO: can these be smaller?
    uint size;
    uint complete_size;
    std::vector<block> blocks;
};

struct mem_op {
    int placeholder;
};

class MemQueue {
    std::queue<mem_op> operations;
    Memory mem;

public:
    //MemQueue();
    void push(mem_op op);
    void pop();
    void empty();
};