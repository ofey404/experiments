#include "callback.h"

size_t WriteCallback(void *contents, size_t size, size_t nmemb, std::string *userp) {
    userp->append((char *) contents, size * nmemb);
    return size * nmemb;
}
