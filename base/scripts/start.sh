#!/bin/bash
echo "---Ensuring UID: 99 matches user---"
usermod -u 99 browser
echo "---Ensuring GID: 100 matches user---"
groupmod -g 100 browser > /dev/null 2>&1 ||:
usermod -g 100 browser
echo "---Setting umask to 000---"
umask 000

HOST=$(cat /hostname)
MAX_TRIES=10
tries=0

# Tries to send request to Server
while [ $tries -lt $MAX_TRIES ]; do
  tries=$((tries+1))
  response=$(curl -s -d "{ \"status\": \"started\",\"serviceName\": \"$SERVICE_NAME\",\"host\": \"$HOST\" }" -H "Content-Type: application/json" $WEBHOOK_URL)

  # If server is accessible and correct response
  if [ "$response" -eq 200 ]; then
    echo "Successfully sent Webhook"
    break
  else
    echo "Request $tries/$MAX_TRIES failed to $WEBHOOK_URL. Response: $response"
    sleep 1
  fi

  # Max retries reached without success
  if [ $tries -eq $MAX_TRIES ]; then
    echo "Max retries reached, canceling Request."
  fi
done

echo "---Taking ownership of data...---"
chown -R root:100 /opt/scripts
chmod -R 750 /opt/scripts
chown -R 99:100 /browser
chown -R 99:100 /browserdata

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
chmod -R /browser /browser
screen -wipe 2&>/dev/null

trap 'kill ${!}; term_handler' SIGTERM
su browser -c "/opt/scripts/start-server.sh" &
killpid="$!"
while true
do
	wait $killpid
	exit 0;
done