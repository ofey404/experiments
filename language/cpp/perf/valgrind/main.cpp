#include <vector>

void foo() {
    for (int i = 0; i < 1e7; ++i) {
        std::vector<int> v(1000, i);
    }
}

int main() {
    foo();
    return 0;
}
