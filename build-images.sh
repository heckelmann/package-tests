#!/bin/bash

# Get the list of Dockerfiles in the current directory
dockerfiles=$(find dockerfiles/ -name "*.Dockerfile")

# Loop through each Dockerfile
for file in $dockerfiles; do
    # Get the filename without the extension
    filename=$(basename "$file" .Dockerfile)

    # Build the container with the tag
    tag="ghcr.io/heckelmann/package-tests:$filename"
    docker build -t "$tag" -f "$file" .

    # Push the container
    docker push "$tag"
done