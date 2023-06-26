# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE:-$0}" )" &> /dev/null && pwd )
# echo "$SCRIPT_DIR"

if [ $# -ne 1 ]
then
  echo "specify minutes"
  return
fi
while true
do
  echo "about to execute stretch routine"
  $SCRIPT_DIR/stretch_routine.sh
  sleep $((60*$1)) # specify number of minutes
done
