#!/bin/bash

set -e

echo "Stop the old container:"
echo "------------------------------------------------------------------------------------"
CID=$(docker ps -q)
if [ "${CID}" ]; then
  docker stop $(docker ps -q)
else
  echo "Cannot find any running container."
fi
unset CID
echo "------------------------------------------------------------------------------------\n"

echo "Start a new container:"
echo "------------------------------------------------------------------------------------"
docker run -dp 3000:3000 --restart unless-stopped --env-file .env -v "$(pwd)":/app -v bundle_data:/usr/local/bundle/gems ep8_members_deploy-app sh -c "rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"
echo "------------------------------------------------------------------------------------\n"
