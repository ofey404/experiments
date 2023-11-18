cmake_minimum_required(VERSION 3.10)
project(my_curl)

set(CMAKE_CXX_STANDARD 14)
# To solve the GTest issue: undefined reference to `typeinfo for testing::Test'
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

find_package(CURL REQUIRED)
find_package(GTest REQUIRED)

# Add the callback directory so that its CMakeLists.txt file gets processed
add_subdirectory(callback)

add_executable(my_curl src/main.cpp)
target_link_libraries(my_curl my_curl_lib)

add_executable(my_curl_test tests/callback_test.cpp)
target_link_libraries(my_curl_test my_curl_lib GTest::GTest GTest::Main)
