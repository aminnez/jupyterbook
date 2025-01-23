FROM ubuntu:22.04

USER root

WORKDIR /srv/jupyterhub

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    unzip \
    apt-transport-https \
    wget \
    curl \
    gnupg \
    git \
    zsh \
    && apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

ENV PATH="/opt/conda/bin:$PATH"

RUN conda update -n base -c defaults conda && \
    conda install -y \
    pip \
    nodejs

RUN conda install -c conda-forge jupyterhub \
    jupyterlab \
    notebook \
    oauthenticator \
    dockerspawner

RUN conda install -c conda-forge jupyterlab-lsp \
    jupyter-lsp \
    python-lsp-server \
    r-languageserver \
    jupyterlab-git


RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | tee /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && apt-get install -y dart

RUN cd /tmp && git clone https://github.com/vickumar1981/jupyter-dart-kernel.git && pip install -e ./jupyter-dart-kernel/ && \
    jupyterdartkernel

RUN curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip && \
    unzip ijava-kernel.zip -d ijava-kernel && \
    cd ijava-kernel && \
    python3 install.py --sys-prefix && \
    cd .. && \
    rm -rf ijava-kernel ijava-kernel.zip


RUN npm install -g tslab && \
    tslab install

RUN export ZSH="/opt/oh-my-zsh" && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    echo "export ZSH=/opt/oh-my-zsh" >> /etc/zsh/zshrc && \
    echo 'plugins=(aliases alias-finder bd command-not-found copyfile copypath docker docker-compose flutter git node npm sudo zsh-autosuggestions zsh-interactive-cd)' >> /etc/zsh/zshrc && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/opt/oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-/opt/oh-my-zsh/custom}/plugins/zsh-completions && \
    echo "fpath+=${ZSH_CUSTOM:-/opt/oh-my-zsh/custom}/plugins/zsh-completions/src" >> /etc/zsh/zshrc && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-/opt/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" --depth 1 && \
    echo "source ${ZSH_CUSTOM:-/opt/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /etc/zsh/zshrc

ENV SHELL=/usr/bin/zsh

EXPOSE 8000

CMD ["jupyterhub"]
