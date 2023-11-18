cmake_minimum_required(VERSION 3.10)
project(lsan)

set(CMAKE_CXX_STANDARD 11)

# Create the production target
add_executable(lsan main.cpp)

# Create the debugging target with LSan enabled
add_executable(lsan_debug main.cpp)
target_compile_options(lsan_debug PUBLIC -fsanitize=leak -fno-omit-frame-pointer -g)
set_target_properties(lsan_debug PROPERTIES LINK_FLAGS -fsanitize=leak)
