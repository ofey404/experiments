cmake_minimum_required(VERSION 3.10)
project(asan)

set(CMAKE_CXX_STANDARD 11)

# Create the production target
add_executable(asan main.cpp)

# Create the debugging target with ASan enabled
add_executable(asan_debug main.cpp)
target_compile_options(asan_debug PUBLIC -fsanitize=address -fno-omit-frame-pointer -g)
set_target_properties(asan_debug PROPERTIES LINK_FLAGS -fsanitize=address)
