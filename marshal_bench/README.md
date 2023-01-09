# Marshal Benchmark

> To my surprise, json.Marshal is slightly faster than `%+v`

Which way of logging faster?

1. Marshal to JSON
2. Printf with reflection (`%+v`)
3. Simple printf

Benchmark result shows performance: 3 > 1 > 2

