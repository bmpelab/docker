#FROM nvidia/cuda:latest
#FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu16.04
FROM tensorflow/tensorflow:1.8.0-gpu-py3

MAINTAINER ogyu <remington2112@g.ecc.u-tokyo.ac.jp>

RUN apt-get update
RUN apt-get install -y libgl1-mesa-dev
RUN apt-get install -y libsm6 libxext6 libxrender-dev

##########################
RUN pip install -U pip
RUN pip3 install opencv-python
RUN pip3 install keras==2.1.5
RUN pip3 install tqdm
RUN pip install --upgrade scipy
##########################


