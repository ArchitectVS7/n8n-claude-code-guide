#!/bin/bash
# Trigger n8n ideation orchestration from command line or Claude Code
# Usage: ./trigger-orchestration.sh <config-file-path>

CONFIG_PATH="$1"

if [ -z "$CONFIG_PATH" ]; then
    echo "Usage: $0 <config-file-path>"
    echo "Example: $0 /workspace/GIT/the-pond/.thursian/ideation-config.json"
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo "Error: Config file not found: $CONFIG_PATH"
    exit 1
fi

echo "Triggering orchestration with config: $CONFIG_PATH"
echo ""

# Send to n8n webhook
curl -X POST http://n8n:5678/webhook/orchestrate \
  -H "Content-Type: application/json" \
  -d "{\"config_path\": \"$CONFIG_PATH\"}"

echo ""
echo "Orchestration triggered!"
