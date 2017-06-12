#!/bin/bash

MODEL_PATH='data/rudychin/face-swap/data/models'

nvidia-docker run \
	-it --rm \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-e APP=face_swap_image \
	-e ARGS="--cfg /root/face_swap/face_swap_image.cfg" \
	ailabs/face-swap:cpu
