#!/bin/bash
set -euo pipefail

# Post-scaffold script to setup dependencies for Vibe Coding project
# Run after scaffolding to install node modules and configure

echo "Setting up dependencies for {{name}} with {{mode_name}} mode..."

# Install npm dependencies
npm install

# Install Backstage CLI if not present
if ! command -v npx @backstage/cli &> /dev/null; then
    npm install --global @backstage/cli
fi

# Mode-specific dependencies (example: install mode-related packages)
case "{{mode_slug}}" in
  "technical-maestro")
    npm install --save-dev typescript eslint
    ;;
  *)
    echo "No specific deps for mode {{mode_slug}}"
    ;;
esac

# Generate app config if needed
npx @backstage/create-app --help || true

echo "Dependencies setup complete. Run 'yarn dev' to start the app."