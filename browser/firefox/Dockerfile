FROM browser_base

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

ENV URL=https://browser.lol/redirect-url-to
ENV WEBHOOK=https://browser.lol/example-webhook

COPY /start-server.sh /opt/scripts/start-server.sh

RUN cd / && \
	wget "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" -O /firefox.tar.bz2 && \
    apt-get update && apt-get install -y bzip2 && \
	tar xvf /firefox.tar.bz2 && \
	rm -R /firefox.tar.bz2

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
