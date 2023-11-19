#include <stdlib.h>

int main() {
    char *x = (char*)malloc(10);  // Allocating memory but not freeing it
    x[10] = 'a'; // Out of bounds write
    return 0;
}
