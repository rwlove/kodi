#!/bin/bash

ARCHIVE_DIR=config_files_archive
CONFIG_FILE_PATH=config_files

[ ! -d ${ARCHIVE_DIR} ] && mkdir ${ARCHIVE_DIR}

pushd ${CONFIG_FILE_PATH}

tar -uvf ../${ARCHIVE_DIR}/kodi_config_files.tar .

popd
