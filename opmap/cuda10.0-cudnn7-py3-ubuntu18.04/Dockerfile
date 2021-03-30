FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

USER root

RUN apt-get update && apt-get install -y \
                   build-essential \
                   git vim curl wget zsh make ffmpeg wget bzip2 unzip \
                   ca-certificates software-properties-common \
                   && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
                   libbz2-dev \
                   libfreetype6-dev \
                   libglib2.0-0 \
                   libgtk2.0-0 \
                   libhdf5-serial-dev \
                   llvm \
                   libncurses5-dev \
                   libncursesw5-dev \
                   libpng-dev \
                   libreadline-dev \
                   libsm6 \
                   libsqlite3-dev \
                   libssl-dev \
                   libxext6 \
                   libxrender1 \
                   libzmq3-dev \
                   zlib1g-dev \
                   cuda-cufft-10-0 \
                   cuda-curand-10-0 \
                   cuda-cusolver-10-0 \
                   cuda-cusparse-10-0 \
                   && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install nvinfer-runtime-trt-repo-ubuntu1604-5.0.2-ga-cuda10.0
RUN apt-get update && apt-get install libnvinfer5=5.1.2-1+cuda10.0
RUN apt-get update && apt-get install -y python3 python3-pip

ENV HOME /root
ENV NOTEBOOK_HOME /notebooks
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

##########################

RUN pip3 install --upgrade pip setuptools
RUN pip3 install cupy-cuda100
RUN pip3 install tensorflow-gpu
RUN pip3 install jupyter
RUN pip3 install jupyterlab
RUN pip3 install opencv-python
RUN pip3 install matplotlib
RUN pip3 install keras
RUN pip3 install pandas
RUN pip3 install scipy
RUN pip3 install numba

##########################

WORKDIR $HOME
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8888" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir = '$NOTEBOOK_HOME'" >> $HOME/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

##########################

RUN echo "cloning dotfiles"
WORKDIR $HOME
RUN git clone https://github.com/chenaoki/dotfiles.git
WORKDIR $HOME/dotfiles
RUN python3 install.py

##########################

RUN mkdir -p $NOTEBOOK_HOME
CMD ["sh", "-c", "jupyter lab --allow-root > $NOTEBOOK_HOME/log.txt 2>&1"]