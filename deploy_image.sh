#!/bin/bash

echo "--------------------"
echo "DEPLOYING THE IMAGE"
echo "--------------------"

PROJECT=gd-gcp-internship-devops
REGION=us-central1
ZONE=us-central1-a
VPC=bdelic-vpc
SUBNET=bdelic-subnet
VM=bdelic-petclinic

VM_LIST=$(gcloud compute instances list --format="value(name, status)" | grep "^$VM")
VM_LIST_RUNNING=$(gcloud compute instances list --format="value(name, status)" | grep "^$VM" | grep "RUNNING$")

if [[ -z $VM_LIST ]]; then
    gcloud compute instances create ${VM} --project=${PROJECT} --zone=us-central1-a --machine-type=e2-small --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=${SUBNET} --metadata-from-file=startup-script=./vm_startup_script.sh --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=71936227901-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=instance-20250227-094512,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250213,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
    echo "VM CREATED!"
    echo "Sleeping for 40 seconds for the startup script to complete"
    sleep 40
else
    gcloud compute instances start ${VM} --zone=${ZONE}
    echo "VM STARTED!"
fi