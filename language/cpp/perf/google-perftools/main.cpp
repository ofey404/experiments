#include <gperftools/profiler.h>
#include <vector>

void foo() {
    for (int i = 0; i < 1e7; ++i) {
        std::vector<int> v(1000, i);
    }
}

int main() {
    ProfilerStart("my_profiler.log");  // Start the profiler
    foo();
    ProfilerStop();  // Stop the profiler
    return 0;
}
