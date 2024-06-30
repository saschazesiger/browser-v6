FROM localhost:5000/j4n11s/browser-v6:base

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
RUN dpkg -i /tmp/chrome.deb || apt-get install -yf
RUN rm /tmp/chrome.deb
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
