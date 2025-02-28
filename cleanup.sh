#!/bin/bash

echo "--------------------"
echo "DELETING RESOURCES"
echo "--------------------"

PROJECT=gd-gcp-internship-devops
REGION=us-central1
ZONE=us-central1-a
VPC=bdelic-vpc
SUBNET=bdelic-subnet
REGISTRY_NAME=bdelic-registry
VM=bdelic-petclinic

gcloud compute instances delete ${VM} --zone=${ZONE}
gcloud artifacts repositories delete ${REGISTRY_NAME} --location=${REGION}
gcloud compute firewall-rules delete bdelic-vpc-allow-custom
gcloud compute firewall-rules delete bdelic-vpc-allow-ssh
gcloud compute networks subnets delete ${SUBNET} --region=${REGION}
gcloud compute networks delete ${VPC}
