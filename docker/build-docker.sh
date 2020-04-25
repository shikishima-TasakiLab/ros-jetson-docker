#!/bin/bash
BUILD_DIR=$(dirname $(readlink -f $0))

docker build -t jetson/ros:melodic-desktop-full ${BUILD_DIR}
