#!/bin/bash

echo -e "Starting Docker service"
sudo systemctl start docker

echo -e "Killing local ADB servers"
~/Android/Sdk/platform-tools/adb kill-server

echo -e "Starting Docker container"
docker run --rm -it --privileged -v /dev/bus/usb:/dev/bus/usb drozer bash
