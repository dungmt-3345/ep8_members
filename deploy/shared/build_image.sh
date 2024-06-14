#!/bin/bash

set -e

echo "------------------------------------------------------------------------------------"

echo "Start build:"
docker build -t ep8_members_deploy-app -f docker/Dockerfile .

echo "List of images after the build:"
docker image ls

echo "------------------------------------------------------------------------------------\n"
