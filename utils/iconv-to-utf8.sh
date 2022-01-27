# https://stackoverflow.com/a/17048486
iconv -f $(file -b --mime-encoding $1) -t utf-8 -c $1 > $2
