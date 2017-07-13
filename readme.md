# Dockerized Fast Face Swap

This is a container for Fast Face Swap inherited from [YuvalNirkin/face_swap](https://github.com/YuvalNirkin/face_swap) with all dependency installed.

Since OpenGL is used, we leverage the browser interface from [thewtex/docker-opengl](https://github.com/thewtex/docker-opengl) to
access OpenGL.

**CPU VERSION IS NOT UNDER MAINTAIN**

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

# Note for run-gpu.sh

Please set `MODEL_PATH` to path that contains the following models:
1. landmarks, e.g. shape_predictor_68_face_landmarks.dat
2. model_3dmm_h5, e.g. BaselFaceModel_mod_wForehead_noEars.h5
3. model_3dmm_dat, e.g. BaselFace.dat
4. reg_model, e.g. dfm_resnet_101.caffemodel
5. reg_deploy, e.g. dfm_resnet_101_deploy.prototxt
6. reg_mean, e.g. dfm_resnet_101_mean.binaryproto
7. seg_model, e.g. face_seg_fcn8s.caffemodel
8. seg_deploy, e.g. face_seg_fcn8s_deploy.prototxt

Please set `IMAGE_PATH` to contain the source images, e.g. Brad Pitt

The parameters given to the docker in `run-gpu.sh` is essential to enable OpenGL.
You should especially take care of `-e DISPLAY=:0`. It should bind to the display.
In case :0 doesn't work anymore:
1. Physically login to the computer, e.g. ws2 (It should connect to a screen)
2. Open a terminal
3. check the working value of DISPLAY by `echo $DISPLAY`

