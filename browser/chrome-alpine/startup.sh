#!/bin/sh

# Start Xvfb (X Virtual Frame Buffer)
Xvfb :1 -screen 0 1024x768x16 &

# Start Fluxbox window manager
fluxbox &

# Start x11vnc server
x11vnc -display :1 -nopw -forever -shared -rfbport 5900 -rfbauth /etc/x11vnc/passwd -bg -o /var/log/x11vnc.log

# Start xterm for the shell (optional, you can replace it with other applications)
xterm -display :1 -geometry 1024x768+0+0 -ls -sb &

x11vnc
