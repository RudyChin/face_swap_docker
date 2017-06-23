#!/bin/sh

MODEL_PATH='/data/rudychin/face-swap/data/models'
IMAGE_PATH='/data/rudychin/face-swap/data/images'
OUTPUT_PATH='/data/rudychin/face-swap/data/output'
TEST_PROGRAM='/usr/bin/python /root/face_swap/py_face_swap/pytest.py'

XSOCK=/tmp/.X11-unix

nvidia-docker run \
	--network=host \
	--privileged \
	-v $XSOCK:$XSOCK:rw \
	-v ~/.Xauthority:/.Xauthority:rw \
	-e DISPLAY=:2 \
	-e XAUTHORITY=/.Xauthority \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-v ${OUTPUT_PATH}:/root/face_swap/data/output \
    ailabs/face-swap:gpu \
    ${TEST_PROGRAM}
