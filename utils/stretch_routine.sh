cvlc --play-and-exit /usr/share/sounds/freedesktop/stereo/bell.oga
for i in {0..5}
do
  sleep 60
  cvlc --play-and-exit /usr/share/sounds/freedesktop/stereo/complete.oga
done
sleep $((60*2))
cvlc --play-and-exit /usr/share/sounds/freedesktop/stereo/complete.oga
cvlc --play-and-exit /usr/share/sounds/freedesktop/stereo/bell.oga
