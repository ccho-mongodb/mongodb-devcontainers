FROM mcr.microsoft.com/devcontainers/java:17

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory, user, and Python interpreter path
ARG PROJECT_DIR=/workspace/java

WORKDIR $PROJECT_DIR
USER $USERNAME
