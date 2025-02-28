#!/bin/bash

echo "--------------------"
echo "PUSHING THE IMAGE"
echo "--------------------"

REGISTRY_NAME=bdelic-registry
PROJECT=gd-gcp-internship-devops
REGION=us-central1
IMAGE=petclinic:latest
GIMAGE=${REGION}-docker.pkg.dev/${PROJECT}/${REGISTRY_NAME}/${IMAGE}

gcloud auth configure-docker ${REGION}-docker.pkg.dev
docker tag ${IMAGE} ${GIMAGE}
docker push ${GIMAGE}

