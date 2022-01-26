# https://stackoverflow.com/questions/54050562/want-to-sum-time-000000-in-awk-command
if [ $# -ne 2 ]
then
  echo "add hours (hh:mm:ss) from a column"
  echo "select the column with argument 1"
  echo "and the file with argument 2"
  echo "example:"
  echo "./awk-hours.sh 1 data.txt"
  exit 2
fi

 awk '{
    split($'$1',a,":")            # separate hs, ms and sses
    b+=a[1]*3600+a[2]*60+a[3]      # sum them up as as seconds
}
END {
    h=int(b/3600)                  # separate hs
    m=int((b-3600*h)/60)           # and ms
    s=b-3600*h-60*m                # and sses
    printf "%d:%02d:%02d\n",h,m,s  # output
}' $2
