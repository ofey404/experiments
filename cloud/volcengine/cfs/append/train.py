import torch
from torch.utils.tensorboard import SummaryWriter
import time
import atexit
import sys

try:
    log_dir = sys.argv[1]
except IndexError:
    log_dir = "./runs"

print(f"## Log dir: {log_dir}")

# Writer will output to ./runs/ directory by default.
writer = SummaryWriter(log_dir)
atexit.register(writer.close)

x = torch.arange(-5, 5, 0.1).view(-1, 1)
y = -5 * x + 0.1 * torch.randn(x.size())

model = torch.nn.Linear(1, 1)
criterion = torch.nn.MSELoss()
optimizer = torch.optim.SGD(model.parameters(), lr=0.1)

epoch = 1
while True:
    y1 = model(x)
    loss = criterion(y1, y)

    writer.add_scalar("Loss/train", loss, epoch)
    epoch += 1

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    print(f"Loss: {loss}/train: {epoch}")

    writer.flush()
    time.sleep(1)

    if epoch >= 15:
        print("## Recreate model")
        model = torch.nn.Linear(1, 1)
