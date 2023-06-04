#include "queue.h"
#include "stdio.h"

void MemQueue::push(mem_op_t op) {
    operations.push(op);
}

void MemQueue::pop() {
    mem_op_t op = operations.front();
    operations.pop();

    // allocate memory
    op.seg->blocks.push_back(mem.alloc());
    op.seg->size += op.size;

    printf("Memory operation - address: %d, size: %d\n", op.data, op.size);
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