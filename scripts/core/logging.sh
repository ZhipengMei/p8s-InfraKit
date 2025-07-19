#!/bin/bash

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Helper Functions ---
log_info() {
  echo
  echo -e "${YELLOW}--- $1 ---${NC}"
}

log_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

log_error() {
  echo -e "${RED}✗ $1${NC}" >&2
}

log_debug() {
  if [ "$1" == "true" ]; then
    echo -e "DEBUG: $2"
  fi
}

log_step() {
  echo
  echo -e "${YELLOW}>>> $1${NC}"
}

log_sub_step() {
  echo -e "  - $1"
}

log_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}
