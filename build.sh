#!/bin/bash

./helper_scripts/create_setting_tar.sh

docker build -t services/kodi --no-cache .

#docker build -t services/kodi .

rm kodi_config_files.tar.gz
