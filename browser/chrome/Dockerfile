FROM local/base:latest

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

ENV URL=https://browser.lol/redirect-url-to
ENV WEBHOOK=https://browser.lol/example-webhook
ENV BANDWIDTH=15000

COPY /start-server.sh /opt/scripts/start-server.sh


RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
RUN dpkg -i /tmp/chrome.deb || apt-get install -yf
RUN rm /tmp/chrome.deb

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
