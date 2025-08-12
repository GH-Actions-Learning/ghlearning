#!/bin/bash

set -e

# Validate required environment variables
if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "[ERROR] GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set."
  exit 1
fi

echo "[INFO] Starting ephemeral GitHub Actions runner setup..."

CONFIG_CMD="./config.sh \
  --url \"$GITHUB_URL\" \
  --token \"$RUNNER_TOKEN\" \
  --name \"$RUNNER_NAME\" \
  --labels \"${RUNNER_LABELS:-ephemeral-org-runner}\" \
  --unattended \
  --ephemeral \
  --replace"

# Add runner group if specified (only for org-level runners)
if [[ -n "$RUNNER_GROUP" ]]; then
  CONFIG_CMD="$CONFIG_CMD --runnergroup \"$RUNNER_GROUP\""
fi

# Run the config command
eval $CONFIG_CMD

echo "[INFO] Runner configured. Starting job listener..."

# No cleanup needed — ephemeral runners auto-remove after job
./run.sh