FROM localhost:5000/j4n11s/browser-v6:base

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" > /etc/apt/sources.list.d/brave-browser-release.list
RUN apt update && apt install brave-browser -y
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
