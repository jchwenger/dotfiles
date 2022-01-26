if [ ! $# -ne 3 ]
then
  echo "three arguments required:"
  echo "./audio2vid.sh <cover-file> <sound-file> <out-file>"
  exit 2
fi

ffmpeg -r 1 -loop 1 -i $1 -i $2 -acodec copy -r 1 -shortest $3
