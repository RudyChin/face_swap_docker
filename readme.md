# Dockerized Fast Face Swap

This is a container for Fast Face Swap inherited from [YuvalNirkin/face_swap](https://github.com/YuvalNirkin/face_swap) with all dependency installed.

Since OpenGL is used, we leverage the browser interface from [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) to
access OpenGL.

# Install

## CPU

Install the docker image by `make docker-cpu`

## GPU

Install the docker image by `./build-gpu.sh` (It will get nvidia-driver.run for you)

# Demo

## CPU

Launch the docker image by `./run.sh`

## GPU

Launch the docker image by `./run-gpu.sh`
