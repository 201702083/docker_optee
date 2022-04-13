#!/bin/bash

export DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0

docker run -ti \
	-e DISPLAY -e XAUTHORITY=/.Xauthority \
	--net host \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ~/.Xauthority:/.Xauthority \
	chsjjjang/optee-v1:1.0
