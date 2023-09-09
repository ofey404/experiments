// example1.cpp

#include <cstdlib>
#include <stdio.h>
using namespace std;
//declaration of functions
int func1();
int func2();

int func1(void) {
    int i=0,g=0;
    while(i++<100000) {
        g+=i;
    }
    return g;
}

int func2(void) {
    int i=0,g=0;
    while(i++<400000) {
        g+=i;
    }
    return g;
}

int main(int argc, char** argv) {
    int iterations = 10000;
    printf("Number of iterations = %d\n", iterations);
    while(iterations--) {
        func1();
        func2();
    }
}