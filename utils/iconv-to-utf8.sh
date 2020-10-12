# https://stackoverflow.com/a/17048486
infile=$1
outfile=$2
iconv -f utf-8 -t utf-8 -c $infile > $outfile
