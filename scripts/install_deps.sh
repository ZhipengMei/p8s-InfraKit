#!/bin/bash

# This script installs all necessary tools for the project.

# --- Source Files ---
source "$(dirname "$0")/core/logging.sh"

# --- Functions ---
check_and_install() {
  local tool=$1
  local install_command=$2

  if ! [ -x "$(command -v "$tool")" ]; then
    log_info "Installing $tool..."
    if eval "$install_command"; then
      log_success "$tool installed successfully."
    else
      log_error "Failed to install $tool."
      exit 1
    fi
  else
    log_success "$tool is already installed."
  fi
}

# --- Main Execution ---
log_step "Checking for Homebrew"
if ! [ -x "$(command -v brew)" ]; then
  log_sub_step "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  log_success "Homebrew installed successfully."
else
  log_success "Homebrew is installed."
fi

log_step "Installing Core Toolchain"
check_and_install "yq" "brew install yq"
check_and_install "docker" "brew install --cask docker"
check_and_install "kind" "brew install kind"
check_and_install "kubectl" "brew install kubectl"
check_and_install "helm" "brew install helm"
check_and_install "helmfile" "brew install helmfile"
check_and_install "kustomize" "brew install kustomize"
check_and_install "go" "brew install go"
check_and_install "python" "brew install python"
check_and_install "node" "brew install node"
check_and_install "dapr" "brew install dapr/tap/dapr-cli"
check_and_install "istioctl" "brew install istioctl"
check_and_install "vault" "brew install vault"
check_and_install "argocd" "brew install argocd"
check_and_install "shellcheck" "brew install shellcheck"
check_and_install "yamllint" "brew install yamllint"
check_and_install "markdownlint" "brew install markdownlint-cli"
check_and_install "pre-commit" "brew install pre-commit"
check_and_install "tree" "brew install tree"
check_and_install "gh" "brew install gh"

log_step "Installing Secrets Management Tools"
check_and_install "kubeseal" "brew install kubeseal"
check_and_install "sops" "brew install sops"
if ! helm plugin list | grep -q "secrets"; then
  log_sub_step "Installing Helm plugin secrets..."
  helm plugin install https://github.com/jkroepke/helm-secrets --version v3.5.0
  log_success "Helm plugin secrets installed successfully."
else
  log_success "Helm plugin secrets is already installed."
fi

log_step "Adding Helm Repositories"
helm repo add dapr https://dapr.github.io/helm-charts/ &> /dev/null || log_success "Helm repo dapr already exists."
helm repo add bitnami https://charts.bitnami.com/bitnami &> /dev/null || log_success "Helm repo bitnami already exists."
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets &> /dev/null || log_success "Helm repo sealed-secrets already exists."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts &> /dev/null || log_success "Helm repo prometheus-community already exists."
helm repo add grafana https://grafana.github.io/helm-charts &> /dev/null || log_success "Helm repo grafana already exists."
helm repo add loki https://grafana.github.io/loki/charts &> /dev/null || log_success "Helm repo loki already exists."
helm repo add tempo https://grafana.github.io/tempo/charts &> /dev/null || log_success "Helm repo tempo already exists."
helm repo add istio https://istio-release.storage.googleapis.com/charts &> /dev/null || log_success "Helm repo istio already exists."
helm repo add hashicorp https://helm.releases.hashicorp.com &> /dev/null || log_success "Helm repo hashicorp already exists."
helm repo add argo https://argoproj.github.io/argo-helm &> /dev/null || log_success "Helm repo argo already exists."
log_sub_step "Updating Helm repositories..."
helm repo update
log_success "Helm repositories updated."

log_success "All dependencies installed."
