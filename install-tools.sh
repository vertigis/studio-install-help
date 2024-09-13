#!/bin/bash
set -e

mkdir -p .temp
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install nano

if ! which az > /dev/null; then
  curl -fsSL https://aka.ms/InstallAzureCLIDeb -o .temp/get-az.sh
  sudo bash ./.temp/get-az.sh
fi

if ! which docker > /dev/null; then
  curl -fsSL https://get-docker.com -o .temp/get-docker.sh
  sudo bash ./.temp/get-docker.sh
fi
