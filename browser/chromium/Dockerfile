FROM browser_base

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

ENV URL=https://browser.lol/redirect-url-to
ENV WEBHOOK=https://browser.lol/example-webhook

COPY /start-server.sh /opt/scripts/start-server.sh


RUN apt update && apt install snapd -y && systemctl start snapd.service && snap install chromium

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
