cmake_minimum_required(VERSION 3.10)

project(google_perftools_example)

find_library(GPERFTOOLS_PROFILER profiler)
if (NOT GPERFTOOLS_PROFILER)
    message(FATAL_ERROR "Profiler library not found")
endif()

# libunwind
find_package(PkgConfig)
pkg_check_modules(libunwind REQUIRED IMPORTED_TARGET GLOBAL libunwind)

add_executable(main_perf main.cpp)
target_link_libraries(main_perf ${GPERFTOOLS_PROFILER} PkgConfig::libunwind)
