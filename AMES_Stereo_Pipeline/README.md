## Instructions

Follow the [Docker](https://github.com/mmartinescu/xesmf-docker#docker) but with the following modifications:

1. Step 4: docker build -t ames-img -f .\Dockerfile .
2. Step 5: docker run --name ames-container -v ${pwd}:/ds -p 8888:8888 ames-img