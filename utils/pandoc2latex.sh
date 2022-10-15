if [ $# -ne 1 ]
then
  echo "usage: ./pandoc2latex.sh [filename]"
  exit
fi

fname="$1"
if [ -f "$fname" ]
then
  read "answ?found $fname, overwrite? [y/n] "
  if [[ "${answ:l}" =~ y ]]
  then
    rm "$fname"
  fi
fi
echo "layout options to separate texts:"
echo " - 1: pagebreak"
echo " - 2: § sign"
read "layout?[1/2] "
if [[ "$layout" == 1 ]]
then
  br="\n\n\\\\pagebreak\n\n"
elif [[ "$layout" == 2 ]]
  br="\n\n~\n\n\\\\begin{center}§\\\\end{center}\n\n~\n\n"
then
else
  echo "wrong option, exiting"
  exit 1
fi
echo "importing: $utils/template.tex"
head -n -2 "$utils/template.tex" >> "$fname"
for f in ${@:2}
do
  echo "$f"
  if ! [[ "$f" =~ ${@: -1} ]] # add a layout break for all but the last doc
  then
    # echo "not the last one: $f"
    pandoc -t latex "$f"         >> "$fname"
    echo "$br"                   >> "$fname"
  else
    # echo "the last one: $f"
    pandoc -t latex "$f"         >> "$fname"
  fi
done
tail -n -2 "$utils/template.tex" >> "$fname"
