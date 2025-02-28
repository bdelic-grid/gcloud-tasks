#!/bin/bash

echo "--------------------"
echo "CREATING VPC, SUBNET, FIREWALL"
echo "--------------------"

PROJECT=gd-gcp-internship-devops
REGION=us-central1
VPC=bdelic-vpc
SUBNET=bdelic-subnet

gcloud auth login

gcloud config set project ${PROJECT}

VPC_LIST=$(gcloud compute networks list | grep "$VPC")
if [[ -z "$VPC_LIST" ]]; then
	gcloud compute networks create ${VPC} --project=${PROJECT} --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional --bgp-best-path-selection-mode=legacy
	echo "VPC CREATED!"
else
	echo "VPC ALREADY EXISTS!"
fi

SUBNETS_LIST=$(gcloud compute networks subnets list | grep "$SUBNET")
if [[ -z "$SUBNETS_LIST" ]]; then
	gcloud compute networks subnets create ${SUBNET} --project=${PROJECT} --range=10.0.0.0/24 --stack-type=IPV4_ONLY --network=${VPC} --region=${REGION}
	echo "SUBNET CREATED!"
else
	echo "SUBNET ALREADY EXISTS!"
fi

FIREWALL_RULES=$(gcloud compute firewall-rules list --format=json | grep "bdelic-*")
if [[ -z "$FIREWALL_RULES" ]]; then
	gcloud compute firewall-rules create bdelic-vpc-allow-custom --project=${PROJECT} --network=${VPC} --direction=INGRESS --priority=1000 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:80,tcp:443,tcp:8080
	gcloud compute firewall-rules create bdelic-vpc-allow-ssh --project=${PROJECT} --network=${VPC} --direction=INGRESS --priority=1000 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:22
	echo "FIREWALL RULES CREATED!"
else
	echo "FIREWALL RULE ALREADY EXISTS!"
fi

