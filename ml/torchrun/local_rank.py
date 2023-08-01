import os
local_rank = int(os.environ["LOCAL_RANK"])

print(f"local_rank: {local_rank}")
