#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

showError() {
  echo "${RED}$1${NC}"
}

showInfo() {
  echo "${BLUE}$1${NC}"
}

showSuccess() {
  echo "${GREEN}$1${NC}"
}
