#!/bin/bash

if [[ $#  -ne 1 ]]; then
  echo "Please provide target folder, e.g. 'usb/coding/projects', where the"
  echo "current dir will be saved as a zip"
  exit 2
else
  target="$1"
  echo "attempting backup to $target, creating dir(s) if necessary"
fi

if [ -d "$target" ]; then
  dir="$(pwd)"
  base="$(basename "$dir")"

  cd ..
  echo "---------------------"
  zip --symlinks -r "$base".zip "$base"
  echo "---------------------"
  echo "moving $base.zip to $target"
  rsync -azvP "$dir".zip "$target"
  rm "$dir".zip
  cd "$base"
else
  echo "target dir '$target' not found"
fi
