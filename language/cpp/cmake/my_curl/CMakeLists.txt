cmake_minimum_required(VERSION 3.10)
project(my_curl)

set(CMAKE_CXX_STANDARD 14)
# To solve the GTest issue: undefined reference to `typeinfo for testing::Test'
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

find_package(CURL REQUIRED)
find_package(GTest REQUIRED)

add_library(my_curl_lib src/callback.cpp)
target_link_libraries(my_curl_lib ${CURL_LIBRARIES})

add_executable(my_curl src/main.cpp)
target_link_libraries(my_curl my_curl_lib)

add_executable(my_curl_test tests/callback_test.cpp)
target_link_libraries(my_curl_test my_curl_lib GTest::GTest GTest::Main)
