set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(MCU "arm")

SET (CMAKE_C_COMPILER_WORKS   1)
SET (CMAKE_CXX_COMPILER_WORKS 1)
#skip ABI checks
SET (CMAKE_DETERMINE_C_ABI_COMPILED   1)
SET (CMAKE_DETERMINE_CXX_ABI_COMPILED 1)


set(LINKER_FILE ${CMAKE_SOURCE_DIR}/hal/${MCU}/linker/linker.ld)

SET(CMAKE_C_COMPILER    ${TOOLCHAIN_PATH}arm-none-eabi-gcc)
SET(CMAKE_CXX_COMPILER  ${TOOLCHAIN_PATH}arm-none-eabi-g++)
#set(CMAKE_ASM_COMPILER  ${TOOLCHAIN_PATH}arm-none-eabi-as)
set(CMAKE_AR                  ${TOOLCHAIN_PATH}arm-none-eabi-ar)
set(CMAKE_OBJCOPY             ${TOOLCHAIN_PATH}arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP             ${TOOLCHAIN_PATH}arm-none-eabi-objdump)
set(CMAKE_SIZE                ${TOOLCHAIN_PATH}arm-none-eabi-size)
set(CMAKE_GDB                 ${TOOLCHAIN_PATH}arm-none-eabi-gdb)
set(CMAKE_SIZE                ${TOOLCHAIN_PATH}arm-none-eabi-size)


#set(CMAKE_EXE_LINKER_FLAGS "--specs=nosys.specs -Wl" CACHE INTERNAL "" FORCE)

#set(CMAKE_EXE_LINKER_FLAGS "-T ${LINKER_FILE} -specs=nosys.specs #-Wl,--gc-sections" CACHE STRING "" FORCE)

set(CMAKE_EXE_LINKER_FLAGS "-T ${LINKER_FILE} --specs=nosys.specs")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)


# Compilation flags
add_compile_options(-mcpu=cortex-m3)
add_compile_options(-mthumb)
add_compile_options(-nostdlib)
add_compile_options(${FPU})
add_compile_options(${FLOAT_ABI})
add_compile_options(-g3)
add_compile_options(-Wall)
add_compile_options(-fdata-sections)
add_compile_options(-ffunction-sections)