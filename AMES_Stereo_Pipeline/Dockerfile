FROM ubuntu

# Adds metadata to the image as a key value pair example LABEL version="1.0"
LABEL maintainer="Mike Martinescu"

##Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND="noninteractive" TZ="America/Vancouver"

#Setup File System
RUN mkdir ds
ENV HOME=/ds
ENV SHELL=/bin/bash
VOLUME /ds
WORKDIR /ds

# Install Ubuntu Packages
RUN apt-get update --fix-missing
RUN apt-get install -y wget bzip2 ca-certificates \
    build-essential \
    cmake \
	make \
	gcc \
	g++
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# Add Conda to PATH
ENV PATH /opt/conda/bin:$PATH

# Copy yml file to that create Conda environment
COPY ames.environment.yml /ds

# Create environment
# See here for reasons why this is done this way: https://pythonspeed.com/articles/activate-conda-dockerfile/
RUN conda env create -f /ds/ames.environment.yml

# Make RUN commands use the new environment:
RUN echo "conda activate myenv" >> ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# Open Ports for Jupyter
EXPOSE 7745

# Run Jupyter Notebook: https://u.group/thinking/how-to-put-jupyter-notebooks-in-a-dockerfile/
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
