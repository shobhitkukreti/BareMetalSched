cmake_minimum_required(VERSION 3.18)
project(URF)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

set (TARGET_NAME firmware)
add_subdirectory(hal)
add_subdirectory(kernel)
add_subdirectory(src)
enable_language(ASM)
set (SRC_DIR ${CMAKE_BINARY_DIR}/src)
set (INCLUDE_DIR ${CMAKE_BINARY_DIR}/include)

file(GLOB_RECURSE C_SOURCES ${SRC_DIR}/*.c )
file(GLOB_RECURSE ASM_SOURCES ${SRC_DIR}/*.S)
file(GLOB_RECURSE HEADERS ${INCLUDE_DIR}/*.h)

include_directories(${INCLUDE_DIR})

SET(CMAKE_ASM_FLAGS "${CFLAGS} -x assembler-with-cpp")

add_executable(${TARGET_NAME}
                ${C_SOURCES}
                ${ASM_SOURCES}
                ${HEADERS}
                )


file(COPY ${CMAKE_SOURCE_DIR}/qemu.sh DESTINATION ${CMAKE_BINARY_DIR})

add_custom_command(TARGET ${TARGET_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ARGS -O binary 
    ${TARGET_NAME} main.bin
)