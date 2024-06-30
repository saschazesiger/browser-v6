FROM localhost:5000/j4n11s/browser-v6:base

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN cd / && \
    apt update && apt install -y bzip2 && \
	wget "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" -O /firefox.tar.bz2 && \
	tar xvf /firefox.tar.bz2 && \
	rm -R /firefox.tar.bz2
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
