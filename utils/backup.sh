#!/bin/bash

if [[ $#  -ne 1 ]]; then
  echo "Please provide location folder, e.g. 'usb/coding/projects'"
  exit 2
else
  target="$1"
  echo "attempting backup to $target, creating dir(s) if necessary"
fi

if [ -d "$target" ]; then
  dir="$(pwd)"
  cd dir
  base="$(basename "$dir")"
  # up_dir="${dir%$base}"

  # echo "dir: $dir"
  # echo "base: $base"
  # echo "up dir: $up_dir"

  cd ..
  zip --symlinks -r "$base".zip "$base"
  echo "---------------------"
  echo "moving zip to $target"
  mv "$dir".zip "$target"
  cd "$base"
else
  echo "target dir '$target' not found"
fi
