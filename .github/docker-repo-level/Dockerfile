FROM ghcr.io/actions/actions-runner:2.327.1

USER root

# Best to place files under /home/runner
COPY entrypoint.sh /home/runner/entrypoint.sh

RUN chmod +x /home/runner/entrypoint.sh

# Optional: metadata
# LABEL maintainer=""
# LABEL org.opencontainers.image.source=""

USER runner

ENTRYPOINT ["/home/runner/entrypoint.sh"]