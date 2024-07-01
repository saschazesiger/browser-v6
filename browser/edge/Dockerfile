FROM base

RUN apt-get update && \
	apt-get -y install --no-install-recommends xvfb wmctrl x11vnc websockify fluxbox screen libxcomposite-dev libxcursor1 xauth

RUN  echo "deb http://deb.debian.org/debian bookworm contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
	apt-get update && apt-get -y upgrade && \
	apt-get -y install --no-install-recommends wget locales procps && \
	touch /etc/locale.gen && \
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
	locale-gen && \
	apt-get -y install --reinstall ca-certificates && \
	rm -rf /var/lib/apt/lists/*

RUN  echo "deb http://deb.debian.org/debian bullseye contrib non-free" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install --no-install-recommends fonts-takao fonts-arphic-uming libgtk-3-0 fonts-liberation libasound2 libcurl4 libgbm1 libnss3 libu2f-udev xdg-utils binutils xz-utils dbus dbus-system-bus-common dbus-user-session && \
	apt-get -y install --reinstall ca-certificates && \
	rm -rf /var/lib/apt/lists/*

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
#RUN wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_126.0.2592.81-1_amd64.deb -O /tmp/edge.deb
#RUN dpkg -i /tmp/edge.deb || apt-get install -yf
#RUN rm /tmp/edge.deb
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
