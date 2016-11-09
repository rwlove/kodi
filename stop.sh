#!/bin/bash

docker stop `docker ps | grep services/kodi | cut -d ' ' -f 1`
