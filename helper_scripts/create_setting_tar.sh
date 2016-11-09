#!/bin/bash

CONFIG_FILE_PATH=config_files

pushd ${CONFIG_FILE_PATH}

tar -cvzf kodi_config_files.tar.gz .

popd

mv ${CONFIG_FILE_PATH}/kodi_config_files.tar.gz .
