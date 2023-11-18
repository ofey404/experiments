set(CALLBACK_SRC
        ${CMAKE_CURRENT_LIST_DIR}/callback.cpp
)
add_library(my_curl_lib ${CALLBACK_SRC})
target_include_directories(my_curl_lib PUBLIC ${CMAKE_CURRENT_LIST_DIR})
target_link_libraries(my_curl_lib ${CURL_LIBRARIES})  # Add this line here
