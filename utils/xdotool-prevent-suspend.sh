#!/bin/bash
# https://askubuntu.com/a/931695
while [ `pgrep -x vlc` ]
do
  xdotool key shift
  sleep 60;
done
