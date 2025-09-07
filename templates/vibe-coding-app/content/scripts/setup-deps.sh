#!/bin/bash
# Setup Dependencies Script for Vibe Coding App
echo "Setting up dependencies for Vibe Coding App"

yarn install

# Bump Backstage CLI if needed
yarn backstage-cli versions bump || echo "No bump needed"

echo "Dependencies setup complete."
