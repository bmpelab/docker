# Anaconda3: 4.4.0
# python 

FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

MAINTAINER bmpelab <support@bmpe.t.u-tokyo.ac.jp>

USER root

RUN apt-get update --fix-missing && apt-get -y install \
                   build-essential \
                   git vim curl wget zsh make ffmpeg wget bzip2 \
                   ca-certificates \
                   zlib1g-dev \
                   libssl-dev \
                   libbz2-dev \
                   libreadline-dev \
                   libsqlite3-dev \
                   libglib2.0-0 \
                   libxext6 \
                   libsm6 \
                   libxrender1 \
                   llvm \
                   libncurses5-dev \
                   libncursesw5-dev \
                   libpng-dev \
                   libgtk2.0-0 \
                   mercurial \
                   subversion \
                   python-qt4 


##########################
# Anaconda installation

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh 
RUN /bin/bash ~/anaconda.sh -b -p /opt/conda
ENV PATH /opt/conda/bin:$PATH
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh 
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc 
RUN echo "conda activate base" >> ~/.bashrc


##########################
# python packages installation

RUN conda update -y conda
RUN conda install python=3.6.1
RUN conda install anaconda
RUN conda install -c numba numba
RUN conda install -c numba -y pyculib
RUN conda install --override-channels -c anaconda chainer
RUN conda list
RUN conda install -c conda-forge cudatoolkit=10.0
RUN conda install -c conda-forge cupy

###########################

RUN useradd -U -m -u 999 docker
RUN groupmod -g 999 docker 

ENV HOME /home/docker
ENV NOTEBOOK_HOME $HOME/notebooks

###########################

USER docker
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN mkdir $NOTEBOOK_HOME
RUN chmod 2775 $NOTEBOOK_HOME

##########################


WORKDIR $HOME 
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '*'" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8888" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir = '$NOTEBOOK_HOME'" >> $HOME/.jupyter/jupyter_notebook_config.py


##########################


RUN echo "cloning dotfiles"
WORKDIR $HOME
RUN git clone https://github.com/chenaoki/dotfiles.git
WORKDIR $HOME/dotfiles
RUN python install.py

##########################

WORKDIR $NOTEBOOK_HOME
CMD ["sh", "-c", "jupyter notebook > $NOTEBOOK_HOME/log.txt 2>&1"]
