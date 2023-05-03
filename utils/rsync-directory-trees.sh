#!/bin/zsh
# https://www.cyberciti.biz/faq/unix-linux-bsdosx-copying-directory-structures-trees-rsync/
rsync -av \
  -f"+ */" \
  -f"- *" "$@[1,-2]" "$@[-1]"
