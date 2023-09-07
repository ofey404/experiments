import subprocess


def main():
    popen = subprocess.Popen(
        "for i in 1 2 3 4 5; do echo $i; echo stderr-$i 1>&2; sleep 1; done",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        shell=True,
    )

    for line in popen.stdout:
        print(line.decode(), end="")

    code = popen.wait()
    print(f"code = {code}")


if __name__ == "__main__":
    main()
