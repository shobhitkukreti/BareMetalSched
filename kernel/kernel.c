#include "reg.h"
#include "sys.h"

extern TCB *RUNQ;
extern void main_();

unsigned int k_up_time = 0;


// Setup Timer and start user application
int c_entry() {
  SVC_PRIO(0x06);
  main_();
  return 0;
}

void setup_timer() {
  STRELOAD = 0x7A120;  // 10 msec tick @ 50MHz
  TICK_PRIO(0x07);
  STCTRL = 0x7;  // Enables the timer/interrupt after loading the value
}

void yield(){
  STCURRENT = 0;
  INTCTRL = 0x04000000;
}

void ms_delay(unsigned int msec) {
  unsigned int delay = (msec / 10);
  RUNQ->sleep = delay;
  yield();
}

