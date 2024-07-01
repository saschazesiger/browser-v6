#!/bin/bash
echo "---Ensuring UID: 99 matches user---"
usermod -u 99 browser
echo "---Ensuring GID: 100 matches user---"
groupmod -g 100 browser > /dev/null 2>&1 ||:
usermod -g 100 browser
echo "---Setting umask to 000---"
umask 000

HOST=$(cat /hostname)
curl -s -d "{ \"status\": \"started\",\"serviceName\": \"$SERVICE_NAME\",\"host\": \"$HOST\" }" -H "Content-Type: application/json" $WEBHOOK_URL &

echo "---Taking ownership of data...---"
chown -R root:100 /opt/scripts
chmod -R 750 /opt/scripts
chown -R browser:browser /browser
chown -R browser:browser /browserdata

echo "---Starting...---"
term_handler() {
	kill -SIGTERM "$killpid"
	wait "$killpid" -f 2>/dev/null
	exit 143;
}

echo "---Checking for old logfiles---"
find /browser -name "XvfbLog.*" -exec rm -f {} \;
find /browser -name "x11vncLog.*" -exec rm -f {} \;
echo "---Checking for old display lock files---"
rm -rf /tmp/.X99*
rm -rf /tmp/.X11*
rm -rf /browser/.vnc/*.log /browser/.vnc/*.pid /browser/Singleton*
screen -wipe 2&>/dev/null

trap 'kill ${!}; term_handler' SIGTERM


CUR_V="$(${DATA_DIR}/bin/microsoft-edge --version 2>/dev/null | cut -d ' ' -f3)"
if [ "${MS_EDGE_V}" == "latest" ]; then
  LAT_V="$(wget -qO- https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/ | grep -oP '(?<=href=").*?(?=">)' | awk -F'>' '{print $1}' | grep '^[a-zA-Z]' | sort -V | tail -1 | cut -d '_' -f2 | cut -d '-' -f1)"
  if [ -z "${LAT_V}" ]; then
    if [ -z "${CUR_V}" ]; then
      echo "Something went horribly wrong with version detection!"
	  echo "Can't get latest version and found no current installed version!"
	  echo "Putting container into sleep mode..."
      sleep infinity
	else
	  echo "Couldn't get latest version from Microsoft-Edge, falling back to installed version: ${CUR_V}"
	  LAT_V="${CUR_V}"
    fi
  fi
else
  LAT_V="${MS_EDGE_V}"
fi

if [ -d ${DATA_DIR}/temp ]; then
  rm -rf ${DATA_DIR}/temp
fi

if [ -z "${CUR_V}" ]; then
  echo "---Microsoft Edge not installed, please wait installing...---"
  mkdir -p ${DATA_DIR}/temp ${DATA_DIR}/bin
  cd ${DATA_DIR}/temp
  if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/temp/ms-edge-$LAT_V.deb "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_126.0.2592.81-1_amd64.deb" ; then
    echo "---Sucessfully downloaded Microsoft Edge---"
  else
    echo "---Something went wrong, can't download Microsoft Edge, putting container in sleep mode---"
    sleep infinity
  fi
  ar x ${DATA_DIR}/temp/ms-edge-$LAT_V.deb
  tar -xf ${DATA_DIR}/temp/data.tar.xz
  mv ${DATA_DIR}/temp/opt/microsoft/msedge/* ${DATA_DIR}/bin/
  rm -rf ${DATA_DIR}/temp
elif [ "${CUR_V}" != "${LAT_V}" ]; then
  echo "---Version missmatch, please wait installing latest version: ${LAT_V}...---"
  mkdir -p ${DATA_DIR}/temp
  cd ${DATA_DIR}/temp
  if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/temp/ms-edge-$LAT_V.deb "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_126.0.2592.81-1_amd64.deb" ; then
    echo "---Sucessfully downloaded Microsoft Edge---"
  else
    echo "---Something went wrong, can't download Microsoft Edge, falling back to installed version: ${CUR_V}---"
    rm -rf ${DATA_DIR}/temp
    break
  fi
  rm -rf ${DATA_DIR}/bin
  mkdir -p ${DATA_DIR}/bin
  ar x ${DATA_DIR}/temp/ms-edge-$LAT_V.deb
  tar -xf ${DATA_DIR}/temp/data.tar.xz
  mv ${DATA_DIR}/temp/opt/microsoft/msedge/* ${DATA_DIR}/bin/
  rm -rf ${DATA_DIR}/temp
elif [ "${CUR_V}" == "${LAT_V}" ]; then
  echo "---Microsoft Edge v${CUR_V} up-to-date---"
fi


su browser -c "/opt/scripts/start-server.sh" &
killpid="$!"
while true
do
	wait $killpid
	exit 0;
done