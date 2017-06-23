#!/bin/bash

MODEL_PATH='/data/rudychin/face-swap/data/models'
IMAGE_PATH='/data/rudychin/face-swap/data/images'
OUTPUT_PATH='/data/rudychin/face-swap/data/output'
TGT_CONFIG_PATH='/root/face_swap/data/face_swap_image.cfg'

docker run \
	-it --rm \
	-e app=face_swap_image \
	-e args="--cfg ${tgt_config_path}" \
	-v $1:${tgt_config_path} \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-v ${OUTPUT_PATH}:/root/face_swap/data/output \
	ailabs/face-swap:cpu
	#-p 6080:6080 \
