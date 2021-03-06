# Running xESMF package on Windows

The xESMF python package can only be run in Linux or macOS (as mentioned in the [package documentation](https://xesmf.readthedocs.io/en/latest/installation.html#notes-for-windows-users))
As such, to be able to run it within windows, there are 2 main options:

* [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* [Docker mini-conda](https://hub.docker.com/r/continuumio/miniconda3/)
    * See this [tutorial](https://towardsdatascience.com/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5)

## Instructions

### Windows Subsystem for Linux (WSL)

The instructions are from [WSL instructions](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

1. Open PowerShell
2. Run: `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`.
   This enables the Windows Subsystem for Linux.
3. Run: `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
   This will enable the **Virtual Machine Platform** optional feature.
4. Restart the computer.
5. Download and install the [WSL2 Linux Kernel](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
6. Run: `wsl --set-default-version 2`. This sets the default WSL version to 2.
7. Install your preferred Linux distribution from the (MS Store](https://aka.ms/wslstore). Some examples:
	* [Ubuntu 20.04](https://www.microsoft.com/store/apps/9n6svws3rx71)
	* [Debian](https://www.microsoft.com/store/apps/9MSVKQC78PK6)
8. **[Optional]** [Install Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started)

### Docker

0. Run steps 1 to 6 from *Windows Subsystem for Linux (WSL)*.
1. [Download Docker](https://www.docker.com/get-started) and install it
	* **Note**: No need to create an account or log in.
	* **Note**: Select 'Add to Path' option
2. Download the `Dockerfile` file from this repository
3. Start PowerShell and change directory (`cd`) into the folder you are using
4. Run: `docker build -t xesmf-img -f .\Dockerfile .` and wait for it to complete
5. Run the docker container using: `docker run --name xesmf-container -v ${pwd}:/ds -p 8888:8888 xesmf-img`
6. In a browser, navigate to `http://127.0.0.1:8888/tree`

## Other useful functions/commands

* To add packages to the image, run `docker exec -it xesmf-container bash` from another PowerShell instance.
  You must start the container first by running: `docker start -i xesmf-container`
* Stop all containers: `docker stop $(docker container ls -aq)`
* Remove all containers: `docker rm $(docker container ls -aq)`
