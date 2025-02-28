#!/bin/bash

echo "--------------------"
echo "CREATING GCR"
echo "--------------------"

PROJECT=gd-gcp-internship-devops
REGION=us-central1
REGISTRY_NAME=bdelic-registry


REGISTRY_LIST=$(gcloud artifacts repositories list | grep "$REGISTRY_NAME")
if [[ -z $REGISTRY_LIST ]]; then
    gcloud artifacts repositories create ${REGISTRY_NAME} --repository-format=docker --location=${REGION} --project=${PROJECT} --description="GCR for spring-petclinic"
    echo "REGISTRY CREATED!"
else
    echo "REGISTRY ALREADY EXISTS!"
fi