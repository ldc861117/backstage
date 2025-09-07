#!/bin/bash
# Entity Sync Script for Vibe Coding App
echo "Syncing entities to Backstage Catalog"

# Run the catalog import
backstage-cli catalog-import --fromPath . --toPath catalog-info.yaml

echo "Entity sync complete."
