#!/bin/bash

 if [ -d /media/$(whoami)/JESH_S_USB/coding/projects/ ]; then
	dir="$(pwd)"
	cd dir;
	base="$(basename "$dir")";
	# up_dir="${dir%$base}";

	# echo "dir: $dir"
	# echo "base: $base"
	# echo "up dir: $up_dir"

	cd ..;
	zip --symlinks -r "$base".zip "$base";
	echo "moving zip to usb"
	mv "$dir".zip /media/$(whoami)/JESH_S_USB/coding/projects/;
	cd "$base";
else
	echo "directory /media/$(whoami)/JESH_S_USB/coding/projects/ not found";
fi
