for f in $*
do
  if [[ $f =~ ${@: -1} ]]
  then
    total="$total$(cat $f)"
  else
    total="$total$(cat $f)\f"
  fi
done
echo $total \
| lp \
    -o media=a4 \
    -o cpi=12 \
    -o lpi=7.2 \
    -o page-left=48 \
    -o page-right=48 \
    -o page-top=48 \
    -o page-bottom=48 \
    -o sides=two-sided-short-edge

