#include <stdarg.h>
#include "thread.h"
#include "sys.h"

extern unsigned k_up_time;
extern void setup_timer();
extern TCB *RUNQ;


// Reduce sleeping time of the tasks
void sleeping_tasks_mgt(){
  TCB *slpq = RUNQ;
  slpq = slpq->next;
  do{
    if(slpq->sleep)
      --(slpq->sleep);
    slpq = slpq->next;
  } while (slpq!=RUNQ);
}


// Simple Round Robin Scheduler
void Scheduler(void) { 
  
  uint8_t max_prio = 64;
  TCB *pt;
  TCB *next = RUNQ;
  pt = RUNQ;
  // find a task which is not sleeping and not blocked
  do{
    pt = pt->next;
    
    if((pt->priority < max_prio)&&((pt->is_blocked)==0)&&((pt->sleep)==0)){
      max_prio = pt->priority;
      next = pt;
    }
    
  } while(RUNQ != pt);
  RUNQ = next; 
}


// Handle Periodic Ticks
void SYSTICK() {
  k_up_time++;
  sleeping_tasks_mgt();
  Scheduler();
}


// Handle Software Interrupt, RD/WR/SLEEP/TASK_CREATION
int C_SVC_Hndlr(void *ptr, int svc_num) {
  int ret = 0, len = 0;
  void *stck_loc = ptr;

  switch (svc_num) {
    case 2: {
      char *data = (char*)*(unsigned int *)(stck_loc);  // R0 on stack
      len = *(unsigned int *)(stck_loc + 1);  // R1 on stack
      put(data, len);
      break;
    }
    case 3: {
      char *data = (char*)*(unsigned int *)(stck_loc);  // R0 on stack
      len = *(unsigned int *)(stck_loc + 1);  // R1 on stack
      ret = get(data, len);
      *(int *)ptr = ret; 
      /* Return value stored in r0 location in stack.
       * It will be popped from stack and placed in RO after
       * executing mov pc,lr
       */
      break;
    }
    case 4:
      ms_delay(*(unsigned*)ptr); // *ptr holds the delay value
      break;

    case 31:
      task_create((void *)stck_loc);
      // start timer
      setup_timer();
      break;

    default:
      ret = -1;
  }
  return ret;
}
