#!/bin/bash

# wifi diagnosis
# https://github.com/UbuntuForums/wireless-info
echo "running some diagnoses & saving in ~/wireless-info.txt"
wget -N -t 5 -T 10 https://github.com/UbuntuForums/wireless-info/raw/master/wireless-info
chmod +x wireless-info
./wireless-info
if [ -f wireless-info.tar.gz ]; then
	tar -xvzf wireless-info.tar.gz
	rm wireless-info.tar.gz
fi

