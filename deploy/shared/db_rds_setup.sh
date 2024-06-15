#!/bin/bash

# Lấy container ID của container đang chạy
container_id=$(docker ps -q)

# Kiểm tra nếu có container đang chạy
if [ -z "$container_id" ]; then
  echo "No running container found."
  exit 1
fi

echo "Running 'rails db:migrate:status'..."
if docker exec -it $container_id rails db:migrate:status | grep -q "down"; then
  echo "Running migrations..."
  docker exec -it $container_id rails db:migrate
else
  echo "All migrations are up to date"
fi
