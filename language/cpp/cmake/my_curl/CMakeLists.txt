cmake_minimum_required(VERSION 3.10)
project(my_curl)

set(CMAKE_CXX_STANDARD 14)

find_package(CURL REQUIRED)

add_executable(my_curl src/main.cpp)
target_link_libraries(my_curl ${CURL_LIBRARIES})
