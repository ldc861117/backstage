#!/bin/bash
set -euo pipefail

# Post-scaffold script to sync Vibe Coding project entity to Backstage catalog
# Run after generating vibeproject.yaml to register the component

echo "Syncing {{name}} entity to Backstage catalog with {{mode_name}} mode..."

# Ensure backstage-cli is available
if ! command -v npx @backstage/cli &> /dev/null; then
    npm install --global @backstage/cli
fi

# Import the generated entity YAML to catalog
npx @backstage/cli catalog import --source-file ../vibeproject.yaml --dry-run=false

echo "Entity sync complete. Check the Backstage catalog for {{name}}."