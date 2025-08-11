#!/bin/bash

# EPHEMERAL DOCKER IMAGE

set -e  # Exit immediately on error

# 🧪 Validate required environment variables
if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "[ERROR] GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set as environment variables."
  exit 1
fi

echo "[INFO] Configuring the GitHub Actions runner..."

# Register the runner with --ephemeral
./config.sh \
  --url "$GITHUB_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$RUNNER_NAME" \
  --labels "${RUNNER_LABELS:-ephemeral}" \
  --unattended \
  --ephemeral

echo "[INFO] Runner configured successfully. Starting the runner..."

# 🚀 Start the runner – it will automatically unregister after one job
./run.sh

echo "[INFO] Runner has finished its job and will now exit."
