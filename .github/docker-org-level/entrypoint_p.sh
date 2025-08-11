#!/bin/bash
set -e

# Validate required environment variables
if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "[ERROR] GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set."
  exit 1
fi

echo "[INFO] Configuring persistent GitHub Actions runner at ORG level..."

CONFIG_CMD="./config.sh \
  --url \"$GITHUB_URL\" \
  --token \"$RUNNER_TOKEN\" \
  --name \"$RUNNER_NAME\" \
  --labels \"${RUNNER_LABELS:-org-runner}\" \
  --unattended \
  --replace"

# Add runner group if provided
if [[ -n "$RUNNER_GROUP" ]]; then
  CONFIG_CMD="$CONFIG_CMD --runnergroup \"$RUNNER_GROUP\""
fi

eval $CONFIG_CMD

cleanup() {
  echo "[INFO] Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
  exit 0
}

trap 'cleanup' SIGINT SIGTERM

echo "[INFO] Starting persistent runner..."
./run.sh

echo "[INFO] Runner stopped."



# docker run -d \
#   --name ghr4 \
#   -e GITHUB_URL=https://github.com/GH-Actions-Learning \
#   -e RUNNER_TOKEN=A23ZVMQX6IYCIZ6JZSCSOSLITIXSO \
#   -e RUNNER_NAME=dk-runner-4 \
#   -e RUNNER_LABELS=dk-run4,ep4 \
#   -e RUNNER_GROUP=docker \
#   --restart always \
#   ghi3:latest