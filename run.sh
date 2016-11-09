#!/bin/bash

export DISPLAY=:0

echo "allowing X access (xhost +)"
xhost +

echo "stopping screensaver"
/usr/local/bin/screensaverStop.sh

echo "is docker running?"
ps axf | grep docker

. settings.conf

[ ! -d logs ] && mkdir logs/
[ ! -f logs/kodi.log ] && touch logs/kodi.log

BUILD_DIR=/home/rwlove/docker_build/kodi/kodi

docker run \
       -d \
       -e DISPLAY=$DISPLAY \
       --privileged \
       -v /etc/machine-id:/etc/machine-id \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /dev/shm:/dev/shm \
       -v /run/user/$uid/pulse:/run/user/$uid/pulse \
       -v /var/lib/dbus:/var/lib/dbus \
       -v ~/.pulse:/root/.pulse \
       -v /etc/localtime/:/etc/localtime/:ro \
       -v ${BUILD_DIR}/data/kodi/userdata/Database/:/root/.kodi/userdata/Database/ \
       -v ${BUILD_DIR}/Database/bubba:/root/.kodi/userdata/profiles/${USER_NAME}/Database \
       -v ${BUILD_DIR}/Database/Guest:/root/.kodi/userdata/profiles/Guest/Database \
       -v ${BUILD_DIR}/logs/kodi.log:/root/.kodi/temp/kodi.log \
       -p 8080:8080 \
       -p 9090:9090 \
       -p 1900:1900 \
       -p 9777:9777 \
       -h kodi \
       --restart=always \
       services/kodi:17.0-git20161028.1906-beta5-0vivid
#services/kodi:17.0-BETA3-20161004
