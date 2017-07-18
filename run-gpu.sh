#!/bin/sh
#
#
# To test:
#     ./run-gpu.sh test
#
# To run custom command:
#     ./run-gpu.sh {CMD} {PORT}
#

MODEL_PATH='/data/face_swap/data/models'
IMAGE_PATH='/data/face_swap/data/images'
OUTPUT_PATH='/data/face_swap/data/output'
PORT=8899

XSOCK=/tmp/.X11-unix

if [ "$1" = "test" ];
then
    GPUID=$2
    CMD="/usr/bin/python /root/face_swap/py_face_swap/pytest.py ${GPUID}"
elif [ "$1" = "defaultHigh" ];
then
    GPUID=$2
    CMD="/usr/bin/python /root/face_swap/py_face_swap/fs_service.py --port 8899 --gpu ${GPUID} --highQual 1 --idol 4"
elif [ "$1" = "defaultLow" ];
then
    GPUID=$2
    CMD="/usr/bin/python /root/face_swap/py_face_swap/fs_service.py --port 2266 --gpu ${GPUID} --highQual 0 --idol 4"
else
    if [ $# -eq 2 ];
    then
        echo "Input Command: $1"
        echo "Port $2"
        CMD=$1
        PORT=$2
    else
        echo "Wrong number of arguments"
    fi
fi


nvidia-docker run \
    -it \
	--network=host \
	--privileged \
	-v $XSOCK:$XSOCK:rw \
	-v ~/.Xauthority:/.Xauthority:rw \
	-e DISPLAY=:0 \
	-e XAUTHORITY=/.Xauthority \
    -p ${PORT}:${PORT} \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-v ${OUTPUT_PATH}:/root/face_swap/data/output \
    registry.corp.ailabs.tw/lab/face-swap:gpu \
    ${CMD}
