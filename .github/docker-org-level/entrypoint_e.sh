#!/bin/bash
set -e

# Validate required environment variables
if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "[ERROR] GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set."
  exit 1
fi

echo "[INFO] Configuring ephemeral GitHub Actions runner at ORG level..."

CONFIG_CMD="./config.sh \
  --url \"$GITHUB_URL\" \
  --token \"$RUNNER_TOKEN\" \
  --name \"$RUNNER_NAME\" \
  --labels \"${RUNNER_LABELS:-org-runner}\" \
  --unattended \
  --ephemeral"

# Add runner group if provided
if [[ -n "$RUNNER_GROUP" ]]; then
  CONFIG_CMD="$CONFIG_CMD --runnergroup \"$RUNNER_GROUP\""
fi

eval $CONFIG_CMD

echo "[INFO] Starting ephemeral runner..."
./run.sh

echo "[INFO] Runner job completed and runner exited."
