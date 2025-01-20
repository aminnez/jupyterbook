# Dockerfile for JupyterHub Development Environment
#
# This Dockerfile creates a comprehensive JupyterHub container with:
# - Base JupyterHub image
# - Java development environment
# - Jupyter and JupyterLab
# - IJava kernel for Java programming
#
# Build and run instructions:
# 1. Build: docker build -t jupyterhub-dev .
# 2. Run: docker run -p 8000:8000 jupyterhub-dev

# Use official JupyterHub base image as the foundation
# This image provides the core JupyterHub infrastructure and dependencies
FROM jupyterhub/jupyterhub

# Switch to root user to perform system-level package installations
# Necessary for installing system packages and development tools
USER root

# Update package lists and install Java Development Kit
# - openjdk-11-jdk: Provides Java 11 development environment
# - unzip: Utility for extracting compressed files during kernel installation
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    unzip \
    # Clean up to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter core packages
# - jupyter: Core Jupyter notebook interface
# - jupyterlab: Advanced web-based interactive development environment
# Use --no-cache-dir to minimize image size
RUN pip3 install --no-cache-dir \
    jupyter \
    jupyterlab

# Install JupyterHub and OAuthenticator
RUN pip3 install \
    dockerspawner \
    oauthenticator
# Install IJava Kernel for Java programming in Jupyter notebooks
# Process:
# 1. Download IJava kernel release
# 2. Unzip kernel files
# 3. Install kernel system-wide
RUN curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip \
    && unzip ijava-kernel.zip -d ijava-kernel \
    && cd ijava-kernel \
    && python3 install.py --sys-prefix \
    # Clean up downloaded files
    && cd .. \
    && rm -rf ijava-kernel ijava-kernel.zip
