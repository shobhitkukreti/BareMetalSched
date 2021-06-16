#ifndef THREAD_H_
#define THREAD_H_

#pragma once

#include <stdint.h>

#define KSTACK 0x2000FFFF

#define STACK_SIZE 100
#define TIME_FACTOR 1
#define MAX_TASK 63
#define IDLE_TASK_PRIO 63

void SetInitialStack(uint8_t threadID);

typedef struct _systcb_ TCB;

struct _systcb_{
	int32_t *sp;
	uint8_t priority;
	uint8_t is_blocked;
	unsigned int C,T,e,t, sleep;
	TCB *next;
};



int32_t STACK[MAX_TASK+1][STACK_SIZE];

typedef struct _task_struct {
				void *func;
				unsigned int priority;
				unsigned int C;
				unsigned int T;

}TASK_STRUCT;


TCB OS_TCB[MAX_TASK];
TCB *run_list[MAX_TASK];
TCB *sleep_list[MAX_TASK];


void context_switch_full(TCB *prev, TCB *next);
void context_switch_half(TCB *tcb);
uint8_t next_highest_priority();
int task_create(void *setup_ptr);

#endif


