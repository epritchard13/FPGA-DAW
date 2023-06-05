#include "queue.h"
#include "stdio.h"

void MemQueue::push(mem_op_t op) {
    if (full()) {
        printf("Error: tried to push to full queue\n");
        return;
    }
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
    uint size = std::min((uint) BLOCK_SIZE, op.seg->complete_size - BLOCK_SIZE * op.seg->blocks.size());
    block_t b = mem.alloc();
    op.seg->blocks.push_back(b);
    op.seg->size += size;

    printf("Memory operation - address: %d, size: %d, block: %d\n", op.data, size, b);
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