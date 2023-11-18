cmake_minimum_required(VERSION 3.10)

project(crow_http_server)

set(CMAKE_CXX_STANDARD 14)

# The source directory
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

# Add the executable
add_executable(${PROJECT_NAME} ${SOURCE_DIR}/main.cpp)

find_package(Crow CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Crow::Crow)
