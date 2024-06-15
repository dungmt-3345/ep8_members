#!/bin/bash

set -e

echo "------------------------------------------------------------------------------------"

if [ $# -ne 2 ]; then
  echo "Error: No configuration specified. Please provide a method (branch or tag) and a target for fetching."
  exit 1
fi

git fetch

method=$1
target=$2

if [ "$method" = "branch" ]; then
  echo "Fetching branch: $target"
  git checkout "$target"
  git pull
elif [ "$method" = "tag" ]; then
  echo "Fetching tag: $target"
  git checkout "tags/$target"
else
  echo "Error: Invalid method specified. Please use 'branch' or 'tag'."
  exit 1
fi

echo "------------------------------------------------------------------------------------"
