cmake_minimum_required(VERSION 3.10)
project(my_curl)

set(CMAKE_CXX_STANDARD 14)
# To solve the GTest issue: undefined reference to `typeinfo for testing::Test'
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

find_package(CURL REQUIRED)
find_package(GTest REQUIRED)

# Add the directories so that their CMakeLists.txt files get processed
add_subdirectory(callback)
add_subdirectory(src)  # Add this line
add_subdirectory(tests)  # And this line
