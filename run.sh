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

BUILD_DIR=${PWD}

echo "USER_ID = ${USER_UID}"

docker run \
       -dt \
       -e DISPLAY=${DISPLAY} \
       --privileged \
       -e PULSE_SERVER=tcp:192.168.1.4:4713 \
       -e PULSE_COOKIE=/run/pulse/cookie \
       -v /dev/shm:/dev/shm \
       -v /etc/machine-id:/etc/machine-id \
       -v /var/lib/dbus:/var/lib/dbus \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /dev/dri/:/dev/dri \
       -v ${BUILD_DIR}/Database/Guest:/home/${USER}/.kodi/userdata/profiles/Guest/Database \
       -v ${BUILD_DIR}/logs/kodi.log:/home/${USER}/.kodi/temp/kodi.log \
       -v ${BUILD_DIR}data/kodi/userdata/Thumbnails:/home/rwlove/.kodi/userdata/Thumbnails \
       -v ${BUILD_DIR}/data/kodi/userdata/Database/:/home/${USER}/.kodi/userdata/Database/ \
       -v ${BUILD_DIR}/Database/bubba:/home/${USER}/.kodi/userdata/profiles/${USER_NAME}/Database \
       -v ${BUILD_DIR}/xfer:/xfer \
       -p 8080:8080 \
       -p 9090:9090 \
       -p 1900:1900 \
       -p 9777:9777 \
       -h kodi\
       --restart=always \
       services/kodi:v17.6
