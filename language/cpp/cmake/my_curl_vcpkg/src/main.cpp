#include <iostream>
#include <curl/curl.h>
#include "callback.h"

int main() {
    CURL *curl = curl_easy_init();
    if (curl) {
        CURLcode res;
        std::string readBuffer;

        curl_easy_setopt(curl, CURLOPT_URL, "http://www.google.com");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);
        res = curl_easy_perform(curl);

        if (res != CURLE_OK)
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        else
            std::cout << readBuffer << std::endl;

        curl_easy_cleanup(curl);
    }
    return 0;
}
