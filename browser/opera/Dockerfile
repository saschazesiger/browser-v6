FROM localhost:5000/j4n11s/browser-v6:base

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN apt-get update && apt-get -y install --no-install-recommends gsettings-desktop-schemas 
RUN wget -q -nc --show-progress --progress=bar:force:noscroll -O /tmp/opera.deb "https://download.opera.com/download/get/?id=62544&location=415&nothanks=yes&sub=marine&utm_tryagain=yes"
RUN dpkg -i /tmp/opera.deb || apt-get install -yf
RUN rm /tmp/opera.deb

# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
