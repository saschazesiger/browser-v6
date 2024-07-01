FROM localhost:5000/j4n11s/browser-v6:base

RUN  apt-get update  && apt-get -y install --no-install-recommends xdg-utils binutils xz-utils dbus dbus-system-bus-common dbus-user-session

COPY /start-server.sh /opt/scripts/start-server.sh

# ------------ Install Browser ------------
RUN LAT_V=$(wget -qO- https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/ | grep -oP '(?<=href=").*?(?=">)' | awk -F'>' '{print $1}' | grep '^[a-zA-Z]' | sort -V | tail -1 | cut -d '_' -f2 | cut -d '-' -f1) && mkdir /install && wget -q -nc --show-progress --progress=bar:force:noscroll -O /install/edge.deb "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_${LAT_V}-1_amd64.deb"
RUN cd /install && ar x ./edge.deb && tar -xf ./data.tar.xz
RUN mv /install/opt/microsoft/msedge/* /bin/
RUN rm -rf /install
# ------------ End Install Browser ------------

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]
