# Dockerized Face Swap

This is a dockerized version of [YuvalNirkin/face_swap](https://github.com/YuvalNirkin/face_swap) with all dependency installed.

Since OpenGL is used, we leverage the browser interface from [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) to
access OpenGL.

# Install

## CPU

Install the docker image by `make docker-cpu`

## GPU

Install the docker image by `./build-gpu.sh` (It will get nvidia-driver.run for you)

# Data

Fetch models by `./fetch_data.sh`
Modify the `MODEL_PATH` variable in `run.sh` to point to the model path

# Demo

## CPU

Launch the docker image by `sudo ./run.sh`

## GPU

Launch the docker image by `sudo ./run-gpu.sh`
