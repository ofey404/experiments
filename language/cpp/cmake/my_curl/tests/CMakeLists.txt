set(TEST_FILES
        ${CMAKE_CURRENT_LIST_DIR}/callback_test.cpp
)

add_executable(my_curl_test ${TEST_FILES})
target_link_libraries(my_curl_test my_curl_lib GTest::GTest GTest::Main)
