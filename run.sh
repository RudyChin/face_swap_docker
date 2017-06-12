#!/bin/bash

MODEL_PATH='/data/rudychin/face-swap/data/models'
IMAGE_PATH='/data/rudychin/face-swap/data/images'

nvidia-docker run \
	-it --rm \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-e APP=face_swap_image \
	-e ARGS="--cfg /root/face_swap/face_swap_image.cfg" \
	ailabs/face-swap:cpu
