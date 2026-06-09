FROM mcr.microsoft.com/devcontainers/ruby:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=vscode

# Set the working directory and user
ARG PROJECT_DIR=/workspace/ruby

WORKDIR $PROJECT_DIR
USER $USERNAME
