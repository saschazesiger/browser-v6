#!/bin/bash
export DISPLAY=:99
export XAUTHORITY=/browser/.Xauthority

echo "---Checking for old logfiles---"
find /browser -name "XvfbLog.*" -exec rm -f {} \;
find /browser -name "x11vncLog.*" -exec rm -f {} \;
echo "---Checking for old display lock files---"
rm -rf /tmp/.X99*
rm -rf /tmp/.X11*
rm -rf /browser/.vnc/*.log /browser/.vnc/*.pid /browser/Singleton*
chmod -R /browser /browser
screen -wipe 2&>/dev/null

echo "---Starting Pulseaudio server---"
#pulseaudio -D -vvvvvvv --exit-idle-time=-1
mkdir -p ~/pulse/.config/pulse
echo -n 'gIvST5iz2S0J1+JlXC1lD3HWvg61vDTV1xbmiGxZnjB6E3psXsjWUVQS4SRrch6rygQgtpw7qmghDFTaekt8qWiCjGvB0LNzQbvhfs1SFYDMakmIXuoqYoWFqTJ+GOXYByxpgCMylMKwpOoANEDePUCj36nwGaJNTNSjL8WBv+Bf3rJXqWnJ/43a0hUhmBBt28Dhiz6Yqowa83Y4iDRNJbxih6rB1vRNDKqRr/J9XJV+dOlM0dI+K6Vf5Ag+2LGZ3rc5sPVqgHgKK0mcNcsn+yCmO+XLQHD1K+QgL8RITs7nNeF1ikYPVgEYnc0CGzHTMvFR7JLgwL2gTXulCdwPbg=='| base64 -d>~/pulse/.config/pulse/cookie
HOME=$HOME/pulse pulseaudio --start --exit-idle-time=-1
pulseaudio --start --exit-idle-time=-1
HOME=$HOME/pulse pactl load-module module-native-protocol-tcp
PULSE_PID=$(ps --no-headers -C pulseaudio -o pid | sed -r 's/( )+//g')

nohup ffmpeg -y -nostdin -f alsa -i pulse  -f mpegts  -codec:a mp2 udp://localhost:1234 &
#ffmpeg -f alsa -i pulse -f mpegts -codec:a mp2 -ar 44100 -ac 2 -b:a 128k udp://localhost:10000 &

/opt/scripts/goproxy &

echo "---Starting TurboVNC server---"
vncserver -geometry 1024x768 -depth 16 :99 -rfbport 5900 -noxstartup -securitytypes none 2>/dev/null

echo "---Starting Fluxbox---"
screen -d -m env HOME=/etc /usr/bin/fluxbox


echo "---Starting Chrome---"
cd /browser

while true
do
  trickle -d 15000 -u 15000 /usr/bin/google-chrome ${URL} -no-sandbox --disable-accelerated-video --bwsi --new-window --test-type --disable-accelerated-video --disable-gpu --dbus-stub --no-default-browser-check --no-first-run --bwsi --user-data-dir=/browser --disable-features=Titlebar --disable-dev-shm-usage>/dev/null &
  sleep 5
  while pgrep -x "chrome" > /dev/null
  do
    sleep 1
  done
done
