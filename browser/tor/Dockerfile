FROM base

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

ENV URL=https://browser.lol/redirect-url-to
ENV WEBHOOK=https://browser.lol/example-webhook
ENV BANDWIDTH=15000

COPY /start-server.sh /opt/scripts/start-server.sh


RUN apt-get update && \
	apt-get -y install --no-install-recommends xz-utils fonts-takao fonts-arphic-uming libgtk-3-0 libgconf-2-4 libnss3 fonts-liberation libasound2 libcurl3-gnutls libcurl3-nss libcurl4 libgbm1 libnspr4 libnss3 libu2f-udev xdg-utils jq



RUN mkdir /tmp-profile && \
	mkdir /browserdata && \
	cd /browserdata && \
	download_link=$(curl -s "https://www.torproject.org/download/" | grep -o -m 1 'href="/dist/torbrowser/.*.tar.xz"' | sed 's/^href="//;s/"$//') &&\
	wget -q -nc --show-progress --progress=bar:force:noscroll -O /browserdata/Tor-Browser.tar.xz "https://www.torproject.org$download_link" &&\
	tar -C /browserdata --strip-components=2 -xf /browserdata/Tor-Browser.tar.xz && \
	rm -f /browserdata/Tor-Browser.tar.xz && \
	cp -R /tmp-profile /browserdata/TorBrowser/Data/ && \
	rm -f /browserdata/Tor-Browser.tar.xz && \
	rm -rf /tmp-profile

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
