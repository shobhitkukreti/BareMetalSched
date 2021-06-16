#ifndef SYS_H_
#define SYS_H_

#pragma once

#include "thread.h"
#include "reg.h"

#define NULL 0

extern int write( void *, int);
extern int read( void *, int);
extern int sleep(int);
extern void start_os();
extern void create_task(void*, int);

int stringlen(const char *ptr);
int put(char *ptr, int len);
void putch(char ch);
int int2ascii(int num, char*str);
int get(char *ptr, int len);
void ms_delay(unsigned int msec);
void setup_timer();
void getch(char ch);

void enable_interrupts();
void disable_interrupts();

#endif
