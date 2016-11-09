#!/bin/bash

# sson - activate screen and power mgmt
xscreensaver -no-splash > /dev/null 2>&1 &
xset s 100
xset +dpms
