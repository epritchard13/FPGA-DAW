#include "queue.h"

void MemQueue::push(mem_op_t op) {
    operations.push(op);
}

void MemQueue::pop() {
    operations.pop();
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