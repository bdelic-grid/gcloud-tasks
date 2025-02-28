#!/bin/bash

REGISTRY_NAME=bdelic-registry
PROJECT=gd-gcp-internship-devops
REGION=us-central1
IMAGE=petclinic:latest
GIMAGE=${REGION}-docker.pkg.dev/${PROJECT}/${REGISTRY_NAME}/${IMAGE}

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker pull bole1709/main:actions
sudo docker run -d -p 8080:8080 bole1709/main:actions 

