#!/bin/bash

gcloud logging write example-log "API Proxy executed successfully."



export PROJECT_ID=$(gcloud info --format='value(config.project)')
gcloud iam service-accounts create apigee-stackdriver \
  --display-name "Service account for Apigee Stackdriver integration"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:apigee-stackdriver@$PROJECT_ID.iam.gserviceaccount.com --role roles/logging.logWriter

gcloud iam service-accounts keys create key.json \
    --iam-account=apigee-stackdriver@$PROJECT_ID.iam.gserviceaccount.com


