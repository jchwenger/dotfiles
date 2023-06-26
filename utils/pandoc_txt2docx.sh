fname="$1"
# echo "${@:2}"
total=""
for f in ${@:2}
do
  # echo "$f"
  if [[ $f =~ ${@: -1} ]]
  then
    total="$total$(cat $f | sed 's/^\*\*\*$/☙/')"
  else
    total="$total$(cat $f | sed 's/^\*\*\*$/☙/')\n\n\\pagebreak\n\n"
  fi
done

# add two spaces at the end of § lines for markdown
# total=$(echo -e $total | perl -0777 -pe 's/(.)\n(?!\n)/$1  \n/')

# echo $total
echo "$total" | pandoc -f markdown -t docx --lua-filter=pagebreak.lua -s -o $fname
