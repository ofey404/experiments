#include <iostream>

int main() {
    char* leaky_memory = new char[100];
    std::cout << "Memory allocated but not freed!\n";
    return 0;
}
