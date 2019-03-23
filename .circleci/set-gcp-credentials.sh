#!/bin/sh

if [ "$ENV" == "prd" ]; then
  echo $GCP_TERRAFORM_JSON | base64 -d > $GOOGLE_BACKEND_CREDENTIALS
  echo $GCP_TERRAFORM_JSON_PRD | base64 -d > $GOOGLE_APPLICATION_CREDENTIALS
else
  echo $GCP_TERRAFORM_JSON | base64 -d > $GOOGLE_BACKEND_CREDENTIALS
  echo $GCP_TERRAFORM_JSON | base64 -d > $GOOGLE_APPLICATION_CREDENTIALS
fi