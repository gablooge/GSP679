#!/bin/bash
gcloud auth revoke --all

while [[ -z "$(gcloud config get-value core/account)" ]]; 
do echo "waiting login" && sleep 2; 
done

while [[ -z "$(gcloud config get-value project)" ]]; 
do echo "waiting project" && sleep 2; 
done

export PROJECT_ID=$(gcloud info --format='value(config.project)')
gcloud iam service-accounts create apigee-stackdriver \
  --display-name "Service account for Apigee Stackdriver integration"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:apigee-stackdriver@$PROJECT_ID.iam.gserviceaccount.com --role roles/logging.logWriter

gcloud iam service-accounts keys create key.json \
    --iam-account=apigee-stackdriver@$PROJECT_ID.iam.gserviceaccount.com


gcloud logging write example-log "API Proxy executed successfully."

