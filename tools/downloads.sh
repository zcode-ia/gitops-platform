#!/bin/bash

# Set the Github repository directory
GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

# ---------------------------------------------
# List for AMD64 machines
# ---------------------------------------------
# TERRAFORM from https://releases.hashicorp.com/terraform
TERRAFORM_VERSION=1.10.5

# for Linux local machine
# curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "${GIT_ROOT_DIR}/bin/terraform_${TERRAFORM_VERSION}_${OSTYPE}.zip"

# for Windows local machine
curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_windows_amd64.zip" -o "${GIT_ROOT_DIR}/bin/terraform_${TERRAFORM_VERSION}_${OSTYPE}.zip"

# for MacOS local machine
# curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_darwin_amd64.zip" -o "${GIT_ROOT_DIR}/bin/terraform_${TERRAFORM_VERSION}_${OSTYPE}.zip"

# For Github runner pipeline
curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "${GIT_ROOT_DIR}/bin/terraform_${TERRAFORM_VERSION}_runner.zip"
