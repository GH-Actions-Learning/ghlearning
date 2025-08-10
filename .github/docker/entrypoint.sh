#!/bin/bash

set -e


if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "❌ GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set as environment variables."
  exit 1
fi

# Configure runner
./config.sh \
  --url "$GITHUB_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$RUNNER_NAME" \
  --labels "${RUNNER_LABELS:-docker}" \
  --unattended \
  --replace

# Cleanup on exit
cleanup() {
  echo "🧹 Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
  exit 0
}
trap 'cleanup' SIGINT SIGTERM

# Run the runner
echo "🚀 Starting runner..."
./run.sh