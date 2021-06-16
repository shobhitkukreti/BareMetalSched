

@ Wrappers for System Calls

.thumb
.syntax unified
.type write, %function

.equ WRITE_SWI,0x02
.equ READ_SWI,0x03
.equ EXIT,0x01
.equ SLEEP, 0x04
.equ TASK_CREATE, 0x1F

.align 2
.section .text

.global write
.thumb_func
write:
	stmfd sp!,{lr} @ Caller Saved Registers
	push {r4-r11}
	svc #WRITE_SWI
	pop {r4-r11}
	ldmfd sp!,{lr}
	mov pc,lr

.global read
.thumb_func
read:
	stmfd sp!,{lr}
	push {r4-r11}
	SVC #READ_SWI
	pop {r4-r11}
	ldmfd sp!,{lr}
	mov pc,lr

.global sleep
.thumb_func
sleep:
	stmfd sp!,{lr}
	push {r4-r11}
	SVC #SLEEP
	pop {r4-r11}
	ldmfd sp!,{lr}
	mov pc,lr

.global create_task
.thumb_func
create_task: @r0-r3 are saved automatically. 
	stmfd sp!,{lr}
	push {r4-r11}
	SVC #TASK_CREATE
	pop {r4-r11}
	ldmfd sp!,{lr}
	mov pc,lr
	
