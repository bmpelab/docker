# ベースイメージ
FROM nvidia/cuda:11.4.3-cudnn8-devel-ubuntu20.04

# メンテナ情報
MAINTAINER bmpelab <support@bmpe.t.u-tokyo.ac.jp>

# rootユーザーとして実行
USER root

# タイムゾーンの設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 必要なパッケージのインストール
RUN apt-get update --fix-missing && apt-get -y install \
                   build-essential \
                   git vim curl wget zsh make ffmpeg bzip2 \
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
                   subversion

# Python 3.7のPPAを追加し、インストール
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.7 python3.7-dev python3.7-venv python3-pip

# デフォルトのPythonを3.7に設定
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# pipのアップグレード
RUN python3.7 -m pip install --upgrade pip

# Pythonパッケージのインストール
RUN pip3 install numpy scipy matplotlib ipython jupyter pandas sympy nose h5py
RUN pip3 install numba
RUN pip3 install chainer
RUN pip3 install cupy-cuda114  # CUDA 11.4用のCuPy
RUN pip3 install torch torchvision torchaudio
RUN pip3 install tqdm
RUN pip3 install protobuf==3.20.0
RUN pip3 install pyculib
RUN pip3 install natsort
RUN pip3 install isort
RUN pip3 install opencv-python

# ユーザーの追加
RUN useradd -U -m -u 999 docker
RUN groupmod -g 999 docker 

# 環境変数の設定
ENV HOME /home/docker
ENV PATH="/home/docker/.local/bin:${PATH}"
ENV NOTEBOOK_HOME $HOME/notebooks
ENV LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH

# ユーザーの変更
USER docker
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# ノートブックディレクトリの作成と設定
RUN mkdir $NOTEBOOK_HOME
RUN chmod 2775 $NOTEBOOK_HOME

# 作業ディレクトリの設定
WORKDIR $HOME 
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '*'" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8888" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir = '$NOTEBOOK_HOME'" >> $HOME/.jupyter/jupyter_notebook_config.py

# dotfilesのクローンとインストール
RUN echo "cloning dotfiles"
WORKDIR $HOME
RUN git clone https://github.com/chenaoki/dotfiles.git
WORKDIR $HOME/dotfiles
RUN python3.7 install.py

# 作業ディレクトリの変更
WORKDIR $NOTEBOOK_HOME

# コンテナ起動時のコマンド
CMD ["sh", "-c", "jupyter notebook > $NOTEBOOK_HOME/log.txt 2>&1"]