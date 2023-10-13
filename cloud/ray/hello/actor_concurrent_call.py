import ray
import time

ray.init()


@ray.remote
class TimeoutedCounter(object):

    def __init__(self):
        print("multiple calls to the same actor would be queued.")
        self.value = 0

    def increment(self):
        print("increment from {} to {}".format(self.value, self.value + 1))
        time.sleep(10)
        self.value += 1
        print("returned, increment from {} to {}".format(self.value, self.value + 1))
        return self.value

    def get_counter(self):
        return self.value


counter = TimeoutedCounter.remote()

obj_ref1 = counter.increment.remote()
obj_ref2 = counter.increment.remote()
print(ray.get(obj_ref2))
