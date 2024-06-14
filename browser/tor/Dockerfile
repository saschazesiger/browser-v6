FROM base

ENV TURBOVNC_V=3.0.3

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

RUN  echo "deb http://deb.debian.org/debian bullseye contrib non-free" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install --no-install-recommends wget locales procps xvfb wmctrl x11vnc fluxbox screen libxcomposite-dev libxcursor1 xauth python3 supervisor dbus-x11 x11-xserver-utils curl unzip gettext pulseaudio pavucontrol trickle ffmpeg fonts-takao fonts-arphic-uming libgtk-3-0 && \
	touch /etc/locale.gen && \
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
	locale-gen && \
	apt-get -y install --reinstall ca-certificates && \
	rm -rf /var/lib/apt/lists/*




RUN mkdir /browser && \
	mkdir /opt/scripts && \
	useradd -d /browser -s /bin/bash "browser" && \
	chown -R "browser" /browser && \
	ulimit -n 2048



COPY default.pa /etc/pulse/default.pa
RUN adduser root pulse-access
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu

ENV URL=https://browser.lol/redirect-url-to

COPY /scripts /opt/scripts

RUN apt-get update && \
	apt-get -y install --no-install-recommends xz-utils fonts-takao fonts-arphic-uming libgtk-3-0 libgconf-2-4 libnss3 fonts-liberation libasound2 libcurl3-gnutls libcurl3-nss libcurl4 libgbm1 libnspr4 libnss3 libu2f-udev xdg-utils jq




ENV URL=https://browser.lol/redirect-url-to

COPY /scripts /opt/scripts

RUN apt-get update && \
	apt-get -y install --no-install-recommends xz-utils fonts-takao fonts-arphic-uming libgtk-3-0 libgconf-2-4 libnss3 fonts-liberation libasound2 libcurl3-gnutls libcurl3-nss libcurl4 libgbm1 libnspr4 libnss3 libu2f-udev xdg-utils jq



RUN mkdir /tmp-profile && \
	mkdir /tor && \
	cd /tor && \
	download_link=$(curl -s "https://www.torproject.org/download/" | grep -o -m 1 'href="/dist/torbrowser/.*.tar.xz"' | sed 's/^href="//;s/"$//') &&\
	wget -q -nc --show-progress --progress=bar:force:noscroll -O /tor/Tor-Browser.tar.xz "https://www.torproject.org$download_link" &&\
	tar -C /tor --strip-components=2 -xf /tor/Tor-Browser.tar.xz && \
	rm -f /tor/Tor-Browser.tar.xz && \
	cp -R /tmp-profile /tor/TorBrowser/Data/ && \
	rm -f /tor/Tor-Browser.tar.xz && \
	rm -rf /tmp-profile

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]