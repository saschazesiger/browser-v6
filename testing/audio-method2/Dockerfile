FROM debian:buster

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=C.UTF-8 DISPLAY=:0.0

# Install dependencies.
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
      bzip2 \
      gstreamer1.0-plugins-good \
      gstreamer1.0-pulseaudio \
      gstreamer1.0-tools \
      libglu1-mesa \
      libgtk2.0-0 \
      libncursesw5 \
      libopenal1 \
      libsdl-image1.2 \
      libsdl-ttf2.0-0 \
      libsdl1.2debian \
      libsndfile1 \
      novnc \
      pulseaudio \
      supervisor \
      ucspi-tcp \
      wget \
      x11vnc \
      xvfb \
      chromium \
 && rm -rf /var/lib/apt/lists/*

# Configure pulseaudio.
COPY default.pa client.conf /etc/pulse/

# Force vnc_lite.html to be used for novnc, to avoid having the directory listing page.
# Additionally, turn off the control bar. Finally, add a hook to start audio.
COPY webaudio.js /usr/share/novnc/core/
RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html \
 && sed -i 's/display:flex/display:none/' /usr/share/novnc/app/styles/lite.css \
 && sed -i "/import RFB/a \
      import WebAudio from './core/webaudio.js'" \
    /usr/share/novnc/vnc_lite.html \
 && sed -i "/function connected(e)/a \
      var wa = new WebAudio('ws://vps-pub.js0.ch:8081/websockify'); \
      document.getElementsByTagName('canvas')[0].addEventListener('mouseover', e => { wa.start(); }, {once : true});" \

    /usr/share/novnc/vnc_lite.html

# Configure supervisord.
COPY supervisord.conf /etc/supervisor/supervisord.conf
ENTRYPOINT [ "supervisord", "-c", "/etc/supervisor/supervisord.conf" ]

# Run everything as standard user/group cloudnix.
RUN groupadd cloudnix \
 && useradd --create-home --gid cloudnix cloudnix
WORKDIR /home/cloudnix
USER cloudnix
