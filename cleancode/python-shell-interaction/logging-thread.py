import logging
import threading

logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(threadName)s] %(name)s - %(message)s",
    level=logging.DEBUG,
)

LOG = logging.getLogger(__name__)


def worker(id: str):
    for _ in range(3):
        LOG.info(f"from worker {id}")


def main():
    LOG.info("start logging")

    all_t = []
    for id in [f"worker-{i}" for i in range(3)]:
        LOG.info(f"create worker {id}")
        t = threading.Thread(target=worker, args=(id,))
        all_t.append(t)

        t.start()

    for t in all_t:
        t.join()


if __name__ == "__main__":
    main()
