add_subdirectory(asm)
add_subdirectory(include)

file(GLOB SRC
  "*.c"
)
file(COPY ${SRC} DESTINATION ${CMAKE_BINARY_DIR}/src)