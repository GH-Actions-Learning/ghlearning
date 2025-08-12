#!/bin/bash
set -e

# Required vars check
if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "[ERROR] GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set."
  exit 1
fi

cd /home/runner

# Optional: wait to avoid session conflict if container restarted quickly
echo "[INFO] Waiting 15s to avoid GitHub session conflicts..."
sleep 15

# Configure if not already configured
if [ ! -f ".runner" ]; then
  echo "[INFO] Configuring GitHub Actions runner..."

  CONFIG_CMD="./config.sh \
    --url \"$GITHUB_URL\" \
    --token \"$RUNNER_TOKEN\" \
    --name \"$RUNNER_NAME\" \
    --labels \"${RUNNER_LABELS:-org-docker}\" \
    --unattended \
    --replace"

  if [[ -n "$RUNNER_GROUP" ]]; then
    CONFIG_CMD="$CONFIG_CMD --runnergroup \"$RUNNER_GROUP\""
  fi

  eval $CONFIG_CMD
else
  echo "[INFO] Runner already configured. Skipping config."
fi

# Cleanup handler
cleanup() {
  echo "[INFO] Caught termination signal. Cleaning up..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
  exit 0
}
trap cleanup SIGINT SIGTERM

# Start the runner
echo "[INFO] Starting runner..."
./run.sh