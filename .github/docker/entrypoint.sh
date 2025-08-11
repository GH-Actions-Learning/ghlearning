#!/bin/bash

set -e


if [[ -z "$GITHUB_URL" || -z "$RUNNER_TOKEN" || -z "$RUNNER_NAME" ]]; then
  echo "GITHUB_URL, RUNNER_TOKEN, and RUNNER_NAME must be set as environment variables."
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
  echo "Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
  exit 0
}
trap 'cleanup' SIGINT SIGTERM

# Run the runner
echo " Starting runner..."
./run.sh




# docker run -d \
#   --name ghr1 \
#   -e GITHUB_URL=https://github.com/GH-Actions-Learning/ghlearning \
#   -e RUNNER_TOKEN=A23ZVMWIMVGIXKL4PUWESTTITIFQC \
#   -e RUNNER_NAME=my-doc-runner-2 \
#   -e RUNNER_LABELS=doc-run1 \
#   --restart always \
#   ghi1:latest
