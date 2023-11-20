cmake_minimum_required(VERSION 3.16)
project(CalculatorFrontend)

set(CMAKE_CXX_STANDARD 14)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Add source files here
add_executable(CalculatorFrontend
        src/main.cpp
        src/Parser.cpp
        src/Compiler.cpp
        src/Expr.cpp
)

# Find the libraries that correspond to the LLVM components
# that we wish to use
llvm_map_components_to_libnames(llvm_libs support core irreader)

# Link against LLVM libraries
target_link_libraries(CalculatorFrontend ${llvm_libs})
