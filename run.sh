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

docker run \
       -dt \
       -e DISPLAY=${DISPLAY} \
       --privileged \
       -v /dev/snd:/dev/snd \
       -v /dev/shm:/dev/shm \
       -v /etc/machine-id:/etc/machine-id \
       -v /run/user/${USER_UID}/pulse:/run/user/${USER_UID}/pulse \
       -v /var/lib/dbus:/var/lib/dbus \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /dev/dri/:/dev/dri \
       -v ${BUILD_DIR}/Database/Guest:/home/${USER}/.kodi/userdata/profiles/Guest/Database \
       -v ${BUILD_DIR}/logs/kodi.log:/home/${USER}/.kodi/temp/kodi.log \
       -v ${BUILD_DIR}/data/kodi/userdata/Database/:/home/${USER}/.kodi/userdata/Database/ \
       -v ${BUILD_DIR}/Database/bubba:/home/${USER}/.kodi/userdata/profiles/${USER_NAME}/Database \
       -v ${BUILD_DIR}/xfer:/xfer \
       -p 8080:8080 \
       -p 9090:9090 \
       -p 1900:1900 \
       -p 9777:9777 \
       -h kodi \
       --restart=always \
       services/kodi:latest
       #       services/kodi:17.0-RC3
#
#       services/kodi:17.0-git20161028.1906-beta5-0vivid /bin/bash
#services/kodi:17.0-BETA3-20161004
