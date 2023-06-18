import time
import multiprocessing


def square(x):
    return x * x


def test_map(repeat):
    start = time.time()
    result = list(map(square, range(repeat)))
    end = time.time()
    print(f"{repeat} map() took", end - start, "seconds")


def test_pool_map(repeat):
    start = time.time()
    with multiprocessing.Pool(processes=multiprocessing.cpu_count()) as pool:
        result = pool.map(square, range(repeat))
    end = time.time()
    print(f"{repeat} Pool().map() took", end - start, "seconds")


if __name__ == '__main__':
    for repeat in [10**i for i in range(5, 10)]:
        test_map(repeat)
        test_pool_map(repeat)
