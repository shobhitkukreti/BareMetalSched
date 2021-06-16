
## RR Scheduler

1. The software includes a basic round robin scheduling rtos with semaphore support.
2. The directory src/task0, src/task1, src/task2 contain the source code for ultrasonic range finder project.
3. It uses API from hal/common/common_stub.c


### Round Robin Scheduler OS for ARM Cortex-M
##### ======================================================================

The Code Implements the following System Calls

Read
Write
Sleep
Create Tasks

The READ/WRITE tasks use the system calls to read or write to the UART device. In the sample Application there are three tasks 
printing either T1, T2, T3. At each system tick, the task pointer called RUNQ moves forward and next task is swapped in and it starts executing.

***********************************************************************

Prerequisite:
1. gcc-arm-none-eabi package
2. qemu-system-arm package 
3. CMake-3.18


*********************************

Tested on Ubuntu 16.04
*********************************

*********************************
To Build:

// Create a build directory
mkdir build

cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchain.cmake ..

//Run
make

*********************************

To Run the Firmware in QEMU

qemu-system-arm -M lm3s6965evb --kernel main.bin --serial stdio


*********************************
To Debug and Single Step Through Code

Terminal 1
qemu-system-arm -M lm3s6965evb --kernel main.bin --serial stdio -s -S
 

Terminal 2

Execute arm-none-eabi-gdb

Execute inside gdb shell
>> file firmware
>> target remote localhost:1234
