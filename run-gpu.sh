#!/bin/sh
#
#
# To test:
#     ./run-gpu.sh test
#
# To run custom command:
#     ./run-gpu.sh {CMD} {PORT}
#

MODEL_PATH="${PWD}/models"
IMAGE_PATH="${PWD}/images"
OUTPUT_PATH="${PWD}/output"

XSOCK=/tmp/.X11-unix

if [ "$1" = "test" ];
then
    GPUID=$2
    CMD="/usr/bin/python /root/face_swap/py_face_swap/pytest.py ${GPUID}"
else
    echo "Input Command: $1"
    CMD=$1
fi


nvidia-docker run \
    -it \
	--network=host \
	--privileged \
	-v $XSOCK:$XSOCK:rw \
	-v ~/.Xauthority:/.Xauthority:rw \
	-e DISPLAY=:0 \
	-e XAUTHORITY=/.Xauthority \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-v ${OUTPUT_PATH}:/root/face_swap/data/output \
    rudychin/face_swap:gpu \
    ${CMD}
