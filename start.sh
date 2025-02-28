#!/bin/bash

./network.sh
./create_gcr.sh
./push_image.sh
./deploy_image.sh