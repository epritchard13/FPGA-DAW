#include "queue.h"
#include "stdio.h"

void MemQueue::push(mem_op_t op) {
    operations.push(op);
}

void MemQueue::pop() {
    if (operations.empty()) {
        printf("Error: tried to pop empty queue\n");
        return;
    }
    mem_op_t op = operations.front();
    operations.pop();

    // allocate memory
    block_t b = mem.alloc();
    op.seg->blocks.push_back(b);
    op.seg->size += op.size;

    printf("Memory operation - address: %d, size: %d, block: %d\n", op.data, op.size, b);
}

bool MemQueue::full() {
    return operations.size() >= MAX_QUEUE_SIZE;
}

bool MemQueue::empty() {
    return operations.size() == 0;
}

void MemQueue::clear() {
    operations = std::queue<mem_op_t>();
}