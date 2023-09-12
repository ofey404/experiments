# Golang Map thread-safety

Golang Map's behavior is like `sync.RWMutex`.
Concurrent read and exclusive write is okay.

[How safe are Golang maps for concurrent Read/Write operations?](https://stackoverflow.com/questions/36167200/how-safe-are-golang-maps-for-concurrent-read-write-operations)

## Experiment

```bash
./run.sh
```
