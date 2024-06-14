#!/bin/bash

export DISPLAY=:99
export XAUTHORITY=/tor/.Xauthority

echo "---Checking for old logfiles---"
find /browser -name "XvfbLog.*" -exec rm -f {} \;
find /browser -name "x11vncLog.*" -exec rm -f {} \;
echo "---Checking for old display lock files---"
rm -rf /tmp/.X99*
rm -rf /tmp/.X11*
rm -rf /browser/.vnc/*.log /browser/.vnc/*.pid /browser/Singleton*
screen -wipe 2&>/dev/null

echo "---Starting Pulseaudio server---"
pulseaudio -D -vvvvvvv --exit-idle-time=-1
ffmpeg -f alsa -i pulse -f mpegts -codec:a mp2 -ar 44100 -ac 2 -b:a 128k udp://localhost:10000 &


echo "---Starting TurboVNC server---"
vncserver -geometry 1024x768 -depth 16 :99 -rfbport 5900 -noxstartup -securitytypes none 2>/dev/null

echo "---Starting Fluxbox---"
screen -d -m env HOME=/etc /usr/bin/fluxbox


echo "---Starting Tor-Browser---"
cd /tor
/tor/start-tor-browser ${URL} --display=:99 -P "default" --setDefaultBrowser 
while true
do
  trickle -d 15000 -u 15000 /tor/start-tor-browser ${URL} --display=:99 --setDefaultBrowser >/dev/null &
  sleep 5
  while pgrep -x "tor" > /dev/null
  do
    sleep 1
  done
done
