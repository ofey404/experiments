import torch
import torch.nn as nn
from torch.utils.data import DataLoader
from torchvision import transforms
from torchvision.datasets import CIFAR10
from torchvision.models import resnet18
from tqdm import tqdm

import colossalai
from colossalai.core import global_context as gpc
from colossalai.logging import get_dist_logger
from colossalai.utils import load_checkpoint
from colossalai.nn.lr_scheduler import CosineAnnealingWarmupLR
from colossalai.nn.optimizer import Lamb, Lars
from colossalai.utils import save_checkpoint


class DummyDataloader():

    def __init__(self, length, batch_size):
        self.length = length
        self.batch_size = batch_size

    def generate(self):
        data = torch.rand(self.batch_size, 3, 224, 224)
        label = torch.randint(low=0, high=10, size=(self.batch_size,))
        return data, label

    def __iter__(self):
        self.step = 0
        return self

    def __next__(self):
        if self.step < self.length:
            self.step += 1
            return self.generate()
        else:
            raise StopIteration

    def __len__(self):
        return self.length


def main():
    # initialize distributed setting
    parser = colossalai.get_default_parser()
    parser.add_argument('--optimizer',
                        choices=['lars', 'lamb'],
                        help="Choose your large-batch optimizer",
                        required=True)
    parser.add_argument(
        '--synthetic',
        action='store_true',
        help="Use synthetic dataset",
    )
    parser.add_argument('--dataset', type=str, help='path to dataset')
    parser.add_argument('--model', type=str, help='path to input model')
    parser.add_argument('--output', type=str, help='path to output folder')
    args = parser.parse_args()

    # launch from torch
    colossalai.launch_from_torch(config=args.config)

    # get logger
    logger = get_dist_logger()
    logger.info("initialized distributed environment", ranks=[0])

    # create synthetic dataloaders
    if args.synthetic:
        train_dataloader = DummyDataloader(length=10, batch_size=gpc.config.BATCH_SIZE)
        test_dataloader = DummyDataloader(length=5, batch_size=gpc.config.BATCH_SIZE)
    else:
        transform_train = transforms.Compose([
            transforms.RandomCrop(32, padding=4),
            transforms.RandomHorizontalFlip(),
            transforms.ToTensor(),
            transforms.Normalize((0.4914, 0.4822, 0.4465), (0.2023, 0.1994, 0.2010)),
        ])

        transform_test = transforms.Compose([
            transforms.ToTensor(),
            transforms.Normalize((0.4914, 0.4822, 0.4465), (0.2023, 0.1994, 0.2010)),
        ])

        train_dataset = CIFAR10(root=args.dataset, train=True, transform=transform_train)
        test_dataset = CIFAR10(root=args.dataset, train=False, transform=transform_test)
        train_dataloader = DataLoader(train_dataset, batch_size=gpc.config.BATCH_SIZE, shuffle=True)
        test_dataloader = DataLoader(test_dataset, batch_size=gpc.config.BATCH_SIZE, shuffle=False)

    # build model
    model = resnet18(num_classes=gpc.config.NUM_CLASSES)
    if args.model:
        print("model is provided")
        load_checkpoint(args.model, model)
    else:
        print("model is not provided")

    # create loss function
    criterion = nn.CrossEntropyLoss()

    # create optimizer
    if args.optimizer == "lars":
        optim_cls = Lars
    elif args.optimizer == "lamb":
        optim_cls = Lamb
    optimizer = optim_cls(model.parameters(), lr=gpc.config.LEARNING_RATE, weight_decay=gpc.config.WEIGHT_DECAY)

    # create lr scheduler
    lr_scheduler = CosineAnnealingWarmupLR(optimizer=optimizer,
                                           total_steps=gpc.config.NUM_EPOCHS,
                                           warmup_steps=gpc.config.WARMUP_EPOCHS)

    # initialize
    engine, train_dataloader, test_dataloader, _ = colossalai.initialize(model=model,
                                                                         optimizer=optimizer,
                                                                         criterion=criterion,
                                                                         train_dataloader=train_dataloader,
                                                                         test_dataloader=test_dataloader)

    logger.info("Engine is built", ranks=[0])

    for epoch in range(gpc.config.NUM_EPOCHS):
        # training
        engine.train()
        data_iter = iter(train_dataloader)

        if gpc.get_global_rank() == 0:
            description = 'Epoch {} / {}'.format(epoch, gpc.config.NUM_EPOCHS)
            progress = tqdm(range(len(train_dataloader)), desc=description)
        else:
            progress = range(len(train_dataloader))
        for _ in progress:
            engine.zero_grad()
            engine.execute_schedule(data_iter, return_output_label=False)
            engine.step()
            lr_scheduler.step()
    save_checkpoint(file=args.output + "/final_checkpoint.pth", model=model, optimizer=optimizer, epoch=epoch)


if __name__ == '__main__':
    main()
