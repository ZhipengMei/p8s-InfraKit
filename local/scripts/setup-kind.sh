#!/bin/bash

# This script sets up the local Kubernetes cluster using Kind.

# --- Source Files ---
source "$(dirname "$0")/../../scripts/core/logging.sh"

# --- Main Execution ---
log_step "Creating Kind cluster..."
kind create cluster --config kind-config.yaml
log_success "Kind cluster created successfully."

log_step "Deploying local-path-provisioner..."
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.24/deploy/local-path-storage.yaml
log_success "local-path-provisioner deployed successfully."
