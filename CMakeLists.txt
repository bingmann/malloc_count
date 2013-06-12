cmake_minimum_required(VERSION 2.8)

set(libSrcs malloc_count.c stack_count.c)
add_library(malloc_count SHARED ${libSrcs})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(test-malloc_count/test test-malloc_count/test.c)
target_link_libraries(test-malloc_count/test malloc_count dl)

add_executable(test-memprofile/test test-memprofile/test.cc)
target_link_libraries(test-memprofile/test malloc_count dl)
