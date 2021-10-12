FROM tensorflow/tensorflow:1.8.0-gpu-py3

MAINTAINER BMPE <support@bmpe.t.u-tokyo.ac.jp>

RUN apt update
RUN apt -y upgrade
RUN apt install -y libgl1-mesa-dev
RUN apt install -y libsm6 libxext6 libxrender-dev ffmpeg

##########################
RUN pip install -U pip
RUN pip3 install opencv-python
RUN pip3 install keras==2.1.5
RUN pip3 install tqdm
RUN pip install --upgrade scipy
##########################


