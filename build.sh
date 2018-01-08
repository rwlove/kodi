#!/bin/bash

. settings.conf

./helper_scripts/create_setting_tar.sh

cat Dockerfile.in | sed "s/{{USER}}/${USER}/g; s/{{PASSWORD}}/${PASSWORD}/g; s/{{USER_UID}}/${USER_UID}/g; s/{{USER_GID}}/${USER_GID}/g" > Dockerfile

#docker build -t services/kodi .
docker build $* -t services/kodi:v17.6 .
