FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

WORKDIR /root/

RUN python -m pip install tensorboard

COPY train.py train.py

ENTRYPOINT [ "/opt/conda/bin/python", "train.py" ]
