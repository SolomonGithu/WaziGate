#!/bin/bash
set -x

cd /var/lib/wazigate/

# Switch everything down
sudo systemctl restart docker
docker-compose down
sleep 5

# Restart
sudo systemctl restart wazigate.service

# Wait for starting
EDGE_STATUS=
while [ "$EDGE_STATUS" != "healthy" ]
do
  EDGE_STATUS=`docker inspect -f {{.State.Health.Status}} waziup.wazigate-edge`
  echo -n "."
  sleep 2
done
echo "Done"
