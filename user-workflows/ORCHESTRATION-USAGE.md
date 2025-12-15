# Orchestration System Usage Guide

## Overview

This system allows you to run Thursian orchestrations (ideation, engineering reviews, feature coding, etc.) on any project repository via n8n and Claude Code.

## Architecture

```
Project Repo (e.g., the-pond)
  ├── .thursian/
  │   ├── personas/          # Dreamer, Doer, etc.
  │   ├── templates/         # dialectic.yaml, etc.
  │   └── projects/
  │       └── {name}/
  │           └── visions/   # Outputs here
  └── ideation-config.json   # Config for this run

Automaton Repo
  ├── workflows/
  │   └── orchestration-ideation.json  # n8n workflow
  ├── trigger-orchestration.sh         # Trigger script
  └── Docker containers
      ├── n8n (orchestrator)
      └── claude-runner (AI)
```

## Quick Start

### 1. Create Config File in Your Project

```bash
cd /workspace/GIT/your-project
cp /workspace/GIT/automaton/orchestration-config-template.json ./ideation-config.json
```

Edit `ideation-config.json`:
- Set `project_name` to your project name
- Set `project_path` to `/workspace/GIT/your-project`
- Set `idea_text` to your initial idea
- Ensure persona paths are correct (usually `.thursian/personas/...`)

### 2. Import Workflow into n8n

1. Go to http://localhost:5678
2. Click "..." → Import from File
3. Select: `C:\dev\GIT\automaton\workflows\orchestration-ideation.json`
4. Activate the workflow

### 3. Trigger from Claude Code

From inside the claude-runner container (via Claude Code or SSH):

```bash
/workspace/GIT/automaton/trigger-orchestration.sh /workspace/GIT/your-project/ideation-config.json
```

Or from Windows/WSL:

```bash
docker exec claude-code-runner bash /workspace/GIT/automaton/trigger-orchestration.sh /workspace/GIT/your-project/ideation-config.json
```

### 4. Monitor Progress

Watch n8n UI: http://localhost:5678 → Executions

Or check Docker logs:
```bash
docker logs -f n8n-orchestration
docker logs -f claude-code-runner
```

### 5. Check Output

Your vision document will be at:
```
your-project/.thursian/projects/your-project-name/visions/vision-v1.md
```

## Triggering from Claude Code Session

Inside a Claude Code session (like this one):

```bash
# Make script executable
chmod +x /workspace/GIT/automaton/trigger-orchestration.sh

# Trigger ideation for the-pond
/workspace/GIT/automaton/trigger-orchestration.sh /workspace/GIT/the-pond/ideation-config-example.json
```

## Config File Format

```json
{
  "orchestration": {
    "type": "ideation",              // Type of orchestration
    "project_name": "my-project",    // Project identifier
    "project_path": "/workspace/...", // Full path to project
    "session_id": null               // Auto-generated if null
  },
  "input": {
    "idea_file": null,               // Path to .md file with idea (optional)
    "idea_text": "...",              // Or inline idea text
    "context_files": []              // Additional context files
  },
  "output": {
    "artifacts_path": ".thursian/projects/{project_name}/visions",
    "filename": "vision-v1.md",
    "metadata_path": ".thursian/projects/{project_name}/project-metadata.json"
  },
  "parameters": {
    "max_rounds": 8,                 // Max Dreamer↔Doer rounds
    "personas": {
      "dreamer": ".thursian/personas/dreamer.md",
      "doer": ".thursian/personas/doer.md",
      "synthesizer": ".thursian/personas/synthesizer.md"
    },
    "aha_triggers": [                // Phrases that signal breakthrough
      "ah-ha",
      "let me call some friends"
    ],
    "memory_namespace": "dialectic/{session_id}"
  }
}
```

## Workflow Design

The n8n workflow:

1. **Receives webhook** with config file path
2. **Loads config** from the project repo
3. **Loads personas** from the project's `.thursian/personas/`
4. **Initializes session** with Claude Code session ID
5. **Round loop**:
   - Dreamer speaks (SSH to Claude with Dreamer persona)
   - Doer responds (SSH to Claude with Doer persona)
   - Check for aha moment or max rounds
   - If continue: loop back to Dreamer
6. **Synthesize** vision document (SSH to Claude with Synthesizer persona)
7. **Write output** to project's `.thursian/projects/.../visions/`
8. **Return result** with success status and output path

## Key Features

### Context Preservation
- Uses Claude Code `--session-id` to maintain conversation context across all rounds
- All Dreamer/Doer exchanges happen in same session
- Synthesizer has access to full conversation history

### Generic & Reusable
- Works with any project that has `.thursian/` structure
- Config file defines everything project-specific
- Same n8n workflow can orchestrate multiple projects

### Self-Contained
- Automaton repo = orchestration engine only
- Project repos = content, personas, outputs
- Clean separation of concerns

## Future Orchestrations

This workflow is for **ideation** (Phase 1). Future workflows:

- `orchestration-roundtable.json` - Focus groups, stakeholder reviews
- `orchestration-engineering-board.json` - PRD creation, architecture design
- `orchestration-planning.json` - Epic/story breakdown
- `orchestration-build.json` - Code implementation with review

All follow the same pattern: generic workflow + project-specific config.

## Troubleshooting

### "Config file not found"
- Ensure path uses `/workspace/` not `C:/dev/`
- Check file exists: `ls -la /workspace/GIT/your-project/ideation-config.json`

### "Persona file not found"
- Verify personas exist in project: `ls .thursian/personas/`
- Check paths in config match actual file locations

### "SSH connection failed"
- Wait 2-3 minutes after `start-docker.bat` for containers to initialize
- Check: `docker ps` shows all containers as "healthy"

### "Claude not authenticated"
- Handled automatically - authentication was copied to container on setup

### Workflow doesn't loop
- Check "Continue Rounds?" node connections
- Ensure loop connects back to "Dreamer Turn" node

## Examples

### Example 1: Ideate on New Game Concept

```json
{
  "orchestration": {
    "type": "ideation",
    "project_name": "zombie-gardener",
    "project_path": "/workspace/GIT/zombie-gardener"
  },
  "input": {
    "idea_text": "A tower defense game where you're a gardener defending your garden from zombies, but plot twist: the plants are what attract the zombies, so you have to balance food production with defense"
  },
  "parameters": {
    "max_rounds": 10
  }
}
```

### Example 2: Ideate on Existing Stalled Project

```json
{
  "orchestration": {
    "type": "ideation",
    "project_name": "ai-dungeon-master",
    "project_path": "/workspace/GIT/ai-dungeon-master"
  },
  "input": {
    "idea_file": "./README.md",
    "context_files": [
      "./docs/original-vision.md",
      "./docs/what-went-wrong.md"
    ]
  },
  "parameters": {
    "max_rounds": 8
  }
}
```

## Next Steps

1. Import the workflow into n8n
2. Test with the-pond example config
3. Verify output is created
4. Adapt for your own projects
5. Build additional orchestration workflows (roundtable, engineering-board, etc.)
