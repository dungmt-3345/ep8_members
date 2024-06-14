#!/bin/bash

echo "Running 'rails db:create db:migrate'..."
container_name=$(docker ps --format '{{.Names}}' | grep 'app')
docker exec -it $container_name rails db:version >/dev/null 2>&1
status=$?
if [ $status -eq 0 ]; then
  echo "Database already exists"
else
  echo "Creating database..."
  docker exec -it $container_name rails db:create
fi

if docker exec -it $container_name rails db:migrate:status | grep -q "down"; then
  echo "Running migrations..."
  docker exec -it $container_name rails db:migrate
else
  echo "All migrations are up to date"
fi
