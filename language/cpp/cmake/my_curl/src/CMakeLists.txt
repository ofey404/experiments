set(SRC_FILES
        ${CMAKE_CURRENT_LIST_DIR}/main.cpp
)

add_executable(my_curl ${SRC_FILES})
target_link_libraries(my_curl my_curl_lib ${CURL_LIBRARIES})
