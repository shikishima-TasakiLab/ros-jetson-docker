#!/bin/bash
BUILD_DIR=$(dirname $(readlink -f $0))

docker build -t jetson/ros:melodic-desktop-full ${BUILD_DIR}
if [[ $? != 0 ]]; then
    echo "エラーにより中断しました．"
    exit 1
fi
