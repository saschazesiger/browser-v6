FROM localhost:5000/j4n11s/browser-v6:base

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_114.0.1823.82-1_amd64.deb?brand=M102 -O /tmp/edge.deb
RUN dpkg -i /tmp/edge.deb || apt-get install -yf
RUN rm /tmp/edge.deb
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
