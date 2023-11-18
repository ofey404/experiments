cmake_minimum_required(VERSION 3.10)
project(valgrind_leakage_detector)

set(CMAKE_CXX_STANDARD 14)

add_executable(leaky main.cpp)
