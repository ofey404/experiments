import psutil


def print_disk_usage(path):
    du = psutil.disk_usage(path)
    print(f"Total disk space in {path}: {du.total / (1024.0 ** 3):.2f} GiB")
    print(f"Used disk space in {path}: {du.used / (1024.0 ** 3):.2f} GiB")
    print(f"Free disk space in {path}: {du.free / (1024.0 ** 3):.2f} GiB")
    print(f"Percentage of disk used in {path}: {du.percent}%")


print_disk_usage("/data")
