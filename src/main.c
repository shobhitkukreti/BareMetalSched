#include "thread.h"
#include "sys.h"


void set2zero(char *ptr, int len);

void notmain() {
  while (1) {
    int len = 0;
    char str[255];
    set2zero(str, 255);
    char *tmp = "INPUT STR::\t";
    write("Hello\n\n\0", 7);
    write(tmp, stringlen(tmp));
    len = read(str, 255);
    write(str, len);
    ms_delay(300);
  }
}

void set2zero(char *ptr, int len) {
  int i = 0;
  for (i = 0; i < len; i++) ptr[i] = '\0';
}

// Sample Tasks
void task1() {
  while (1) {
    write("T1 ", 2);
    // yield cpu
    sleep(1000);
  }
}

void task2() {
  while (1) {
    write("T2 ", 2);
    // yield cpu
    sleep(2000);
  }
}

void task3() {
  while (1) {
    write("T3 ", 2);
    // yield cpu
     sleep(500);
  }
}


// dummy main
// --specs=nosys.specs doesn't work cleanly with cmake
void main(){}

// Real Main
void main_() {
  
  const char *message = " \n\n \
  This a Simple Round Robin Scheduler \n \
  with three tasks printing T1/T2/T3 \n \
  with different sleep cycles.\n\n \
  ";

  const char* info = "Implemented Handlers for Systick and Software Interrupt.\n \
  Implemented SVC based System Calls (READ/WRITE/SLEEP,CREATE_TASK).\n\n \
  ";

  write_ascii();

  write((void*)&message[0], stringlen(message));
  write((void*)&info[0], stringlen(info));
  
  TASK_STRUCT task[3];

  task[0].priority = 8;
  task[0].func = &task1;

  task[1].priority = 5;
  task[1].func = &task2;

  task[2].priority = 10;
  task[2].func = &task3;

  create_task((void*)&task, 3);
  start_os(); 

  /* It should never print DEADBEEF*/
  while (1) {
    write("DEADBEEF\0", 10);
  }
}
