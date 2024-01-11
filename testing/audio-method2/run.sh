#!/bin/bash -eux
docker build . --quiet --tag novnc
docker rm -f novnc || true
docker run \
  --detach \
  --env DISPLAY_SETTINGS="1920x1080x24" \
  --env EXTRA="-smp 4" \
  --publish 8080:8080 \
  --publish 8081:8081 \
  --publish 5900:5900 \
  --rm \
  --name novnc \
  novnc
sleep 3
xdg-open http://localhost:8080
