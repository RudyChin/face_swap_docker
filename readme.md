### Dockerized Face Swap

This is a dockerized version of [YuvalNirkin/face_swap](https://github.com/YuvalNirkin/face_swap) with all dependency installed.

Since OpenGL is used, we leverage the browser interface from [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) to
access OpenGL.

### Install

Install the docker image by `make docker-cpu`
Fetch models by `./fetch_data.sh`
Modify the `MODEL_PATH` variable in `run.sh` to point to the model path

### Demo

Launch the docker image by `sudo ./run.sh`
