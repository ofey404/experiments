#include <gtest/gtest.h>
#include <string>

extern size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* userp);

TEST(WriteCallbackTest, AppendsDataToString) {
    std::string data = "Hello, world!";
    std::string buffer;

    size_t realSize = data.size();
    WriteCallback((void*)data.c_str(), 1, realSize, &buffer);

    EXPECT_EQ(buffer, data);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
