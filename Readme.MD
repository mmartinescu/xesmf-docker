# Running xESMF package on Windows

The xESMF python package can only be run in Linux or macOS (as mentioned in the [package documentation](https://xesmf.readthedocs.io/en/latest/installation.html#notes-for-windows-users))
As such, to be able to run it within windows, there are 2 main options:

* [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* [Docker mini-conda](https://hub.docker.com/r/continuumio/miniconda3/)
    * See this [tutorial](https://towardsdatascience.com/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5)

## Instructions

1. [Download Docker](https://www.docker.com/get-started) and install it
	* **Note**: No need to create an account or log in.
	* **Note**: Select 'Add to Path' option
2. Download the `Dockerfile` file from this repository
3. Start PowerShell and change directory (`cd`) into the folder you are using
4. Run: `docker build -t xesmf -f .\Dockerfile .` and wait for it to complete
5. Run the docker container using: `docker run --name xesmf -v ${pwd}:/ds -p 8888:8888 xesmf`


Other useful functions

* To add packages to the image, run `docker exec -it xesmf bash` from another PowerShell instance.
  You must start the container first by running: `docker start -i xesmf`
* Stop all containers: `docker stop $(docker container ls -aq)`
* Remove all containers: `docker rm $(docker container ls -aq)`