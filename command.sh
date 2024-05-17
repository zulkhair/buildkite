#!/bin/bash

# Define the necessary variables
TARGET_DIR="game"
DOCKERFILE_PATH="Dockerfile"
DOCKERFILE_DEST="game/cardinal"

# Ensure variables are set
if [ -z "$IMAGE_TAG" ]; then
  echo "Error: IMAGE_TAG is not set."
  exit 1
fi

if [ -z "$DOCKER_USERNAME" ]; then
  echo "Error: DOCKER_USERNAME is not set."
  exit 1
fi

if [ -z "$DOCKER_PASSWORD" ]; then
  echo "Error: DOCKER_PASSWORD is not set."
  exit 1
fi

# Clone the repository
git clone $REPO_URL $TARGET_DIR

# Copy Dockerfile to the target directory
cp $DOCKERFILE_PATH $DOCKERFILE_DEST

# Build the Docker image
docker build --tag $IMAGE_TAG $DOCKERFILE_DEST

# Log in to Docker
echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

# Push the Docker image
docker push $IMAGE_TAG
