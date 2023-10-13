import ray
import cupy
import ray.util.collective as col


@ray.remote(num_gpus=1)
class Worker:

    def __init__(self):
        self.buffer = cupy.ones((10,), dtype=cupy.float32)

    def get_buffer(self):
        return self.buffer

    def do_send(self, target_rank=0):
        # this call is blocking
        col.send(self.buffer, target_rank)

    def do_recv(self, src_rank=0):
        # this call is blocking
        col.recv(self.buffer, src_rank)

    def do_allreduce(self):
        # this call is blocking as well
        col.allreduce(self.buffer)
        return self.buffer


# Create two actors
A = Worker.remote()
B = Worker.remote()

# Put A and B in a collective group
col.create_collective_group([A, B], world_siz=2, ranks=[0, 1])

# let A to send a message to B; a send/recv has to be specified once at each worker
ray.get([A.do_send.remote(target_rank=1), B.do_recv.remote(src_rank=0)])

# An anti-pattern: the following code will hang, because it doesn't instantiate the recv side call
ray.get([A.do_send.remote(target_rank=1)])
