FROM ubuntu

# Adds metadata to the image as a key value pair example LABEL version="1.0"
LABEL maintainer="Mike Martinescu"

##Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND="noninteractive" TZ="America/Vancouver"

# Install Ubuntu Packages
RUN apt-get update --fix-missing
RUN apt-get install -y wget bzip2 ca-certificates \
    build-essential \
    byobu \
    curl \
    git-core \
    htop \
    pkg-config \
    python3-dev \
    python3-pip \
    python-setuptools \
    unzip 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*


# Install Miniconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

# Install required packages 
RUN pip3 --no-cache-dir install \
	'intake>=0.6.2' \
	'netCDF4>=1.5.6' \
	'xarray>=0.18.2' \
	'numpy>=1.20.3' \
	'matplotlib>=3.4.2' \
	'jupyter>=1.0.0' \
	'virtualenv>=20.4.6' \
	'pooch>=1.3.0'
	
RUN conda install -c conda-forge xesmf

# Open Ports for Jupyter
EXPOSE 7745

#Setup File System
RUN mkdir ds
ENV HOME=/ds
ENV SHELL=/bin/bash
VOLUME /ds
WORKDIR /ds

# Run Jupyter Notebook: https://u.group/thinking/how-to-put-jupyter-notebooks-in-a-dockerfile/
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
