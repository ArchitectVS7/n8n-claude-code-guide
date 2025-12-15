#!/bin/bash
# Orchestration CLI - Easy command-line interface for triggering orchestrations
# Install: Copy to /usr/local/bin/orchestrate in claude-runner container

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
N8N_URL="${N8N_URL:-http://n8n:5678}"
WEBHOOK_PATH="/webhook/orchestrate"

# Help text
show_help() {
    cat << EOF
Orchestration CLI - Trigger workflows via n8n

Usage:
    orchestrate <type> <config-path>
    orchestrate <type> --project <project-path> [options]

Arguments:
    type            Type of orchestration (ideation, review, build, etc.)
    config-path     Path to JSON config file

Options:
    --project PATH      Path to project (generates config automatically)
    --idea TEXT         Initial idea text (for ideation)
    --max-rounds N      Maximum conversation rounds (default: 8)
    --help             Show this help message

Examples:
    # Using existing config file
    orchestrate ideation /workspace/GIT/the-pond/ideation-config.json

    # Auto-generate config from project
    orchestrate ideation --project /workspace/GIT/the-pond --idea "A game about frogs"

    # Engineering review
    orchestrate review /workspace/GIT/my-app/review-config.json

Environment Variables:
    N8N_URL            n8n base URL (default: http://n8n:5678)

EOF
}

# Parse arguments
TYPE=""
CONFIG_PATH=""
PROJECT_PATH=""
IDEA_TEXT=""
MAX_ROUNDS=8

while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            show_help
            exit 0
            ;;
        --project)
            PROJECT_PATH="$2"
            shift 2
            ;;
        --idea)
            IDEA_TEXT="$2"
            shift 2
            ;;
        --max-rounds)
            MAX_ROUNDS="$2"
            shift 2
            ;;
        *)
            if [ -z "$TYPE" ]; then
                TYPE="$1"
            elif [ -z "$CONFIG_PATH" ]; then
                CONFIG_PATH="$1"
            else
                echo -e "${RED}Error: Unknown argument: $1${NC}"
                show_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate
if [ -z "$TYPE" ]; then
    echo -e "${RED}Error: Orchestration type required${NC}"
    show_help
    exit 1
fi

# Auto-generate config if using --project
if [ -n "$PROJECT_PATH" ]; then
    PROJECT_NAME=$(basename "$PROJECT_PATH")

    # Create temporary config
    CONFIG_PATH="/tmp/orchestrate-${TYPE}-${PROJECT_NAME}-$$.json"

    cat > "$CONFIG_PATH" << EOF
{
  "orchestration": {
    "type": "${TYPE}",
    "project_name": "${PROJECT_NAME}",
    "project_path": "${PROJECT_PATH}",
    "session_id": null
  },
  "input": {
    "idea_file": null,
    "idea_text": "${IDEA_TEXT}",
    "context_files": []
  },
  "output": {
    "artifacts_path": ".thursian/projects/${PROJECT_NAME}/visions",
    "filename": "vision-v1.md",
    "metadata_path": ".thursian/projects/${PROJECT_NAME}/project-metadata.json"
  },
  "parameters": {
    "max_rounds": ${MAX_ROUNDS},
    "personas": {
      "dreamer": ".thursian/personas/dreamer.md",
      "doer": ".thursian/personas/doer.md",
      "synthesizer": ".thursian/personas/synthesizer.md"
    },
    "aha_triggers": [
      "ah-ha",
      "aha moment",
      "let me call",
      "I see it now",
      "this is it"
    ],
    "memory_namespace": "dialectic/{session_id}"
  }
}
EOF

    echo -e "${YELLOW}Generated config: ${CONFIG_PATH}${NC}"
fi

# Validate config file exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo -e "${RED}Error: Config file not found: ${CONFIG_PATH}${NC}"
    exit 1
fi

# Show what we're doing
echo -e "${GREEN}=== Orchestration Request ===${NC}"
echo "Type:       $TYPE"
echo "Config:     $CONFIG_PATH"
echo "n8n URL:    $N8N_URL$WEBHOOK_PATH"
echo ""

# Trigger orchestration
echo -e "${YELLOW}Triggering orchestration...${NC}"

RESPONSE=$(curl -s -X POST "${N8N_URL}${WEBHOOK_PATH}" \
    -H "Content-Type: application/json" \
    -d "{\"config_path\": \"${CONFIG_PATH}\"}" \
    -w "\n%{http_code}")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

# Check response
if [ "$HTTP_CODE" -eq 200 ] || [ "$HTTP_CODE" -eq 201 ]; then
    echo -e "${GREEN}✓ Orchestration triggered successfully!${NC}"
    echo ""
    echo "Response:"
    echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
    echo ""
    echo -e "${YELLOW}Monitor progress at: ${N8N_URL}${NC}"

    # Clean up temp config
    if [[ "$CONFIG_PATH" == /tmp/* ]]; then
        rm -f "$CONFIG_PATH"
    fi

    exit 0
else
    echo -e "${RED}✗ Orchestration failed (HTTP $HTTP_CODE)${NC}"
    echo ""
    echo "Response:"
    echo "$BODY"
    exit 1
fi
