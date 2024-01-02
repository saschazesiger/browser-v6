FROM debian:stable-slim

ENV TURBOVNC_V=3.0.3

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"


RUN  echo "deb http://deb.debian.org/debian bullseye contrib non-free" >> /etc/apt/sources.list && \
	apt-get update && \
	apt -qqy install --no-install-recommends wget procps xvfb wmctrl x11vnc fluxbox screen libxcomposite-dev libxcursor1 xauth python3 supervisor dbus-x11 x11-xserver-utils curl unzip gettext pulseaudio pavucontrol trickle lame ffmpeg fonts-takao fonts-arphic-uming libgtk-3-0 libgconf-2-4 libnss3 fonts-liberation libasound2 libcurl3-gnutls libcurl3-nss libcurl4 libgbm1 libnspr4 libnss3 libu2f-udev xdg-utils && \
	apt-get -y install --reinstall ca-certificates && \
	rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
	wget -O /tmp/turbovnc.deb https://sourceforge.net/projects/turbovnc/files/3.1/turbovnc_3.1_amd64.deb/download && \
	dpkg -i /tmp/turbovnc.deb && \
	rm -rf /opt/TurboVNC/java /opt/TurboVNC/README.txt && \
	cp -R /opt/TurboVNC/bin/* /bin/ && \
	rm -rf /opt/TurboVNC /tmp/turbovnc.deb && \
	sed -i '/# $enableHTTP = 1;/c\$enableHTTP = 0;' /etc/turbovncserver.conf

COPY /x11vnc /usr/bin/x11vnc
RUN chmod 751 /usr/bin/x11vnc


RUN mkdir /browser && \
	mkdir /opt/scripts && \
	useradd -d /browser -s /bin/bash "browser" && \
	chown -R "browser" /browser && \
	ulimit -n 2048

COPY /scripts /opt/scripts/

COPY /conf/ /etc/.fluxbox/
RUN chmod -R 770 /opt/scripts/


RUN adduser root pulse-access
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu

