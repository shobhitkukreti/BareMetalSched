.align 2
.thumb
.syntax unified
.section .isrvectors
 .word  vTopRam                 /* Top of Stack                 */
 .word  Reset_Handler+1               /* Reset Handler                */
 .word  NMI_Handler+1                 /* NMI Handler                  */
 .word  HardFault_Handler+1           /* Hard Fault Handler           */
 .word  MemManage_Handler+1           /* MPU Fault Handler            */
 .word  BusFault_Handler+1            /* Bus Fault Handler            */
 .word  UsageFault_Handler+1          /* Usage Fault Handler          */
 .word  0                           /* Reserved                     */
 .word  0                           /* Reserved                     */
 .word  0                           /* Reserved                     */
 .word  0                           /* Reserved                     */
 .word  SVC_Handler+1                 /* SVCall Handler               */
 .word  DebugMon_Handler+1            /* Debug Monitor Handler        */
 .word  0                           /* Reserved                     */
 .word  PendSV_Handler+1              /* PendSV Handler               */
 .word  SysTick_Handler+1             /* SysTick Handler              */


.type StartOS, %function

.section .text
;.global __cs3_reset

.global Reset_Handler

.thumb_func
Reset_Handler:
  LDR R0, =__cs3_start_asm
  BX R0
 
.thumb_func
__cs3_start_asm:
  # add assembly initializations here
  LDR r0, =c_entry
  BX r0

.weak NMI_Handler
.thumb_func

NMI_Handler:
B	.

.weak HardFault_Handler
.thumb_func
HardFault_Handler:
B 	.


.weak MemManage_Handler
.thumb_func
MemManage_Handler:
B	.

.thumb_func
.weak BusFault_Handler
BusFault_Handler:
B	.

.thumb_func
.weak UsageFault_Handler
UsageFault_Handler:
B	.

.thumb_func:
.weak SVC_Handler
SVC_Handler:
//stm sp!,{lr} 

@ The LR will have value of 0XFFFFFFF. 
@This is exc_return value. 
@Save it before branching to SVC_WRITE

mov r0,sp
push {lr}
CPSID i

// Extract SVC Immediate value
ldr r1,[sp,#28]
ldrb r1,[r1,#-2]
BL C_SVC_Hndlr
pop {lr}
CPSIE i
BX LR

.thumb_func
.weak DebugMon_Handler
DebugMon_Handler:
B	.

.thumb_func
.weak PendSV_Handler
PendSV_Handler:
B	.


.thumb_func
.weak SYSTick_Handler
SysTick_Handler:
CPSID i
STMFD SP!, {R4-R11}
LDR R0,=RUNQ
LDR R1, [R0]
STR SP, [R1]
PUSH {R0, LR}

@STMFD sp!,{lr} 
@Save EXC_Return Value before branching to return from exception

BL SYSTICK 
POP {R0, LR}
LDR R1, [R0]
LDR SP, [R1]
POP {R4-R11}
CPSIE i
BX LR

.global start_os

.extern RUNQ
.thumb_func
start_os:
nop
DSB
ISB
nop
LDR R0,=RUNQ;
LDR R2, [R0]
LDR SP, [R2];
POP {R4-R11}
POP {R0-R3}
POP {R12}
ADD SP, SP,#4
POP {LR}
ADD SP,SP,#4
CPSIE I
BX LR

.end
