#!/bin/bash

if [[ $#  -ne 1 ]]; then
	echo "Please provide location folder, e.g. 'coding/projects'"
else
	target="$1"
	echo "attempting backup to $usb/$target, creating dir(s) if necessary"
fi

if [ -d $usb ]; then
	dir="$(pwd)"
	cd dir
	base="$(basename "$dir")"
	# up_dir="${dir%$base}"

	# echo "dir: $dir"
	# echo "base: $base"
	# echo "up dir: $up_dir"

	cd ..
	zip --symlinks -r "$base".zip "$base"
	echo "moving zip to usb"
	mv "$dir".zip $usb/$target
	cd "$base"
else
	echo "usb stick $usb not found"
fi
