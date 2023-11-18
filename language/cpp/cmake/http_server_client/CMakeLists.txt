cmake_minimum_required(VERSION 3.10)
project(http_server_client)

# Find the Boost libraries
find_package(Boost REQUIRED COMPONENTS system)

# Add the server executable and link it to the Boost libraries
add_executable(server server/main.cpp)
target_link_libraries(server Boost::system)

# Add the client executable and link it to the Boost libraries
add_executable(client client/main.cpp)
target_link_libraries(client Boost::system)
