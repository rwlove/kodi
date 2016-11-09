#!/bin/bash

ID=`docker ps | grep Up | grep 'services/kodi' | cut -d ' ' -f 1`

[ "${ID}" == "" ] && echo "services/kodi is not running" && exit 1

docker exec -it ${ID} bash
