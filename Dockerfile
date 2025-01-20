FROM jupyterhub/jupyterhub

USER root

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Install IJava kernel
RUN curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip
RUN apt install -y unzip
RUN unzip ijava-kernel.zip -d ijava-kernel
RUN pip3 install --no-cache-dir jupyter jupyterlab
RUN cd ijava-kernel \
    && python3 install.py --sys-prefix
RUN pip3 install jupyterlite-javascript-kernel
