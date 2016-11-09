#!/bin/bash

/usr/local/bin/screensaverStop.sh

#strace kodi -fs --debug
kodi -fs --debug
#kodi -fs

/usr/local/bin/screensaverStart.sh
