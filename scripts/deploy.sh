#!/usr/bin/env bash

#Creates the Api AMI
function createApiAmi {
  cd ..
  packer build -var-file=variables.json api.json
}

#Creates the database AMI
function createDatabaseAmi {
  packer build -var-file=variables.json database.json
}

#Creates the frontend AMI
function createFrontendAmi {
  packer build -var-file=variables.json frontend.json
}

#Creates the NAT AMI
function createNatAmi {
  packer build -var-file=variables.json NAT.json
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
  createNatAmi
  terraformLaunch
}

#Calls the main function
main

