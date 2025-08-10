# Use the official GitHub Actions runner image
FROM ghcr.io/actions/actions-runner:2.327.1

# Optional: Install extra dependencies here, if needed
# RUN apt-get update && apt-get install -y <your-packages> && apt-get clean

# Copy your custom entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint executabl

# Set the entrypoint to your script
ENTRYPOINT ["/entrypoint.sh"]