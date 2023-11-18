//
// Created by ofey on 11/18/2023.
//

#ifndef MY_CURL_CALLBACK_H
#define MY_CURL_CALLBACK_H

#include <string>

size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* userp);

#endif //MY_CURL_CALLBACK_H
