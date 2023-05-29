#!/bin/bash
# https://askubuntu.com/a/931695
sleep 2
while [ `pgrep -x vlc` ]
do
 xdotool key shift
 sleep 360;
done
