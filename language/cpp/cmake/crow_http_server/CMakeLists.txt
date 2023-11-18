cmake_minimum_required(VERSION 3.10)

project(crow_http_server)

set(CMAKE_CXX_STANDARD 14)

# The source directory
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

# Add the executable
add_executable(${PROJECT_NAME} ${SOURCE_DIR}/main.cpp)

find_package(Crow CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Crow::Crow)

find_package(nlohmann_json CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE nlohmann_json::nlohmann_json)

find_package(yaml-cpp CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE yaml-cpp::yaml-cpp)

find_package(Boost COMPONENTS program_options REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Boost::program_options)
