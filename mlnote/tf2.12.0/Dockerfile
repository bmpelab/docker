FROM tensorflow/tensorflow:2.12.0-gpu-jupyter

MAINTAINER bmpelab <support@bmpe.t.u-tokyo.ac.jp>

RUN apt update
RUN apt -y upgrade
RUN apt install -y libgl1-mesa-dev
RUN apt install -y libsm6 libxext6 libxrender-dev ffmpeg
##########################
RUN pip install -U pip
RUN pip install opencv-python
RUN pip install tqdm
RUN pip install --upgrade scipy
RUN pip install pandas 
RUN pip install h5py==2.10.0
##########################
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
RUN echo "c.InteractiveShellApp.exec_lines = ['%matplotlib inline']" >> $HOME/.jupyter/jupyter_notebook_config.py
##########################
WORKDIR $NOTEBOOK_HOME
USER 999:999
CMD ["sh", "-c", "jupyter notebook > $NOTEBOOK_HOME/log.txt 2>&1"]
