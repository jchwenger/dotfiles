for i in $*
do
  echo "$i"
  echo "$(convert "$i" -print "Size: %wx%h\n" /dev/null)"
done
