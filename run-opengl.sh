#!/bin/sh

version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | tail -n 1)" = "$1"; }
docker_version=17.03.1
MODEL_PATH='/data/rudychin/face-swap/data/models'
IMAGE_PATH='/data/rudychin/face-swap/data/images'
OUTPUT_PATH='/data/rudychin/face-swap/data/output'
# Docker 1.3.0 or later is required for --device
if ! version_gt "${docker_version}" "1.2.0"; then
	echo "Docker version 1.3.0 or greater is required"
	exit 1
fi

if test $# -lt 1; then
	# Get the latest opengl-nvidia build
	# and start with an interactive terminal enabled
	args="-i -t $(docker images | grep ^opengl-nvidia | head -n 1 | awk '{ print $1":"$2 }')"
else
        # Use this script with derived images, and pass your 'docker run' args
	args="$@"
fi

XSOCK=/tmp/.X11-unix

nvidia-docker run \
	--network=host \
	--privileged \
	-v $XSOCK:$XSOCK:rw \
	-v ~/.Xauthority:/.Xauthority:rw \
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=/.Xauthority \
	-v ${MODEL_PATH}:/root/face_swap/data/models \
	-v ${IMAGE_PATH}:/root/face_swap/data/images \
	-v ${OUTPUT_PATH}:/root/face_swap/data/output \
	$args
