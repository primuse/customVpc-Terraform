#!/usr/bin/env bash

accessKey=$1
secretKey=$2

#Creates the Api AMI
function createApiAmi {
  cd ..
  export AWS_ACCESS_KEY_ID=$accessKey
  export AWS_SECRET_ACCESS_KEY=$secretKey
  packer build api.json
}

#Creates the database AMI
function createDatabaseAmi {
  export AWS_ACCESS_KEY_ID=$accessKey
  export AWS_SECRET_ACCESS_KEY=$secretKey
  packer build database.json
}

#Creates the frontend AMI
function createFrontendAmi {
  export AWS_ACCESS_KEY_ID=$accessKey
  export AWS_SECRET_ACCESS_KEY=$secretKey
  packer build frontend.json
}

#Builds infrastructure and Launches instances with Terraform
function terraformLaunch {
  cd terraform
  terraform init -input=false
  terraform validate
  terraform plan -out=tfplan -input=false
  terraform apply -input=false tfplan
}

function main {
  createApiAmi
  createDatabaseAmi
  createFrontendAmi
  terraformLaunch
}

#Calls the main function
main

