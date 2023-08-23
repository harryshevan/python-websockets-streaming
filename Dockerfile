# Use an official Python runtime with GPU support as a parent image
# see: https://hub.docker.com/r/nvidia/cuda/tags
FROM nvidia/cuda:12.2.0-base-ubuntu20.04

# Set the locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=Europe/Moscow
ARG DEBIAN_FRONTEND=noninteractive

# Set the working directory in the container to /app
WORKDIR /app

# Update the package lists and install Python
ENV PY_VERSION=3.9
RUN apt update
RUN apt install -y software-properties-common curl
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt update -y && \
    apt install -y \
    python${PY_VERSION} \
    python${PY_VERSION}-dev \
    python${PY_VERSION}-distutils && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PY_VERSION} 1 && \
    update-alternatives --set python /usr/bin/python$PY_VERSION && \
    curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Install dependencies
RUN pip install websockets asyncio

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run server.py in the src folder when the container launches
CMD ["python", "server.py"]

