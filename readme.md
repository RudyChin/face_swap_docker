### Dockerized Face Swap

This is a dockerized version of [YuvalNirkin/face_swap](https://github.com/YuvalNirkin/face_swap) with all dependency installed.

Since OpenGL is used, we leverage the browser interface from [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) to
access OpenGL.

### Install

Install the docker image by `docker build -t ailabs/face_swap:opengl .`
Fetch the models needed by `./fetch_data.sh`

### Demo

Launch the docker image by `docker run -d -v $(PWD)/data:/root/face_swap/data:rw -p 6080:6080 ailabs/face_swap:opengl`
