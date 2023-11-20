cmake_minimum_required(VERSION 3.10)
project(my_curl)

set(CMAKE_CXX_STANDARD 14)
# To solve the GTest issue: undefined reference to `typeinfo for testing::Test'
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

# Change find_package to use CONFIG mode for libraries installed with vcpkg
find_package(CURL CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

# Link the libraries to your targets in the respective directories' CMakeLists.txt files
# For example, in the CMakeLists.txt for your src directory, you may have a line like this:
# target_link_libraries(MyTarget PRIVATE CURL::libcurl GTest::gtest GTest::gtest_main)

# Add the directories so that their CMakeLists.txt files get processed
add_subdirectory(callback)
add_subdirectory(src)  # Add this line
add_subdirectory(tests)  # And this line
