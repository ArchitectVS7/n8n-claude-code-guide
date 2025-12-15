# Thursian Workflow System Documentation

**Version:** 2.0.0
**Last Updated:** 2025-12-13

---

## Table of Contents

1. [Overview](#overview)
2. [Workflow Registry](#workflow-registry)
3. [Project Structure](#project-structure)
4. [Workflow Guides](#workflow-guides)
5. [Templates](#templates)
6. [Examples](#examples)
7. [Best Practices](#best-practices)

---

## Overview

The Thursian Workflow System is a multi-agent orchestration framework for transforming ideas into production-ready product requirements through systematic validation and refinement.

### Key Features

- **Multi-Agent Coordination**: Specialized agents with distinct personas and roles
- **Memory Persistence**: AgentDB backend for cross-session context
- **Artifact Tracking**: Comprehensive metadata for all generated documents
- **Workflow Chaining**: Sequential handoffs between validation phases
- **Project-Centric**: All artifacts organized by project

### Workflow Pipeline

```
Idea → Vision → Focus Group → PRD → Stakeholder Review → Technical Design → Implementation
  ↓       ↓          ↓          ↓            ↓                    ↓              ↓
  8      5          7         3             9                   TBD            TBD
rounds  personas   rounds   rounds        sections
```

---

## Workflow Registry

All workflows are registered in `.thursian/workflows/00-metadata.yaml`

### Active Workflows

| ID | File | Name | Status |
|----|------|------|--------|
| `ideation` | `01-ideation-flow.yaml` | Ideation: Dreamer ↔ Doer Dialectic | ✅ Active |
| `focus-group` | `02-focus-group-flow.yaml` | Focus Group: Multi-Persona Validation | ✅ Active |
| `engineering-meeting` | `03-engineering-meeting-flow.yaml` | Engineering Meeting: Technical PRD Creation | ✅ Active |
| `stakeholder-review` | `04-stakeholder-review-flow.yaml` | Stakeholder Review: PRD Validation | ✅ Active |
| `technical-design` | `05-technical-design-flow.yaml` | Technical Design: Architecture & Implementation Plan | 📋 Planned |

---

## Project Structure

```
.thursian/
├── workflows/                    # Workflow definitions
│   ├── 00-metadata.yaml         # Master registry
│   ├── 01-ideation-flow.yaml
│   ├── 02-focus-group-flow.yaml
│   ├── 03-engineering-meeting-flow.yaml
│   └── 04-stakeholder-review-flow.yaml
│
├── agents/                       # System-level agents
│   ├── orchestrator.md
│   ├── planner.md
│   ├── developer.md
│   ├── reviewer.md
│   └── executive-proxy.md
│
├── personas/                     # Workflow-specific personas
│   ├── ideation/
│   ├── focus-group/
│   ├── engineering/
│   └── stakeholder/
│
├── projects/                     # Per-project workspaces
│   └── {project-name}/
│       ├── metadata.json        # Project tracking
│       ├── ideas/
│       ├── visions/
│       ├── focus-groups/
│       ├── prds/
│       └── sessions/
│
├── templates/                    # Reusable templates
│   ├── project-metadata.json
│   ├── session-state.json
│   └── conversation-export.md
│
└── docs/                        # Documentation
    ├── README.md (this file)
    ├── workflows/
    └── examples/
```

---

## Workflow Guides

### Quick Start

1. **Create a new project:**
   ```bash
   mkdir -p .thursian/projects/my-project/{ideas,visions,focus-groups,prds,sessions}
   ```

2. **Write your initial idea:**
   ```bash
   # .thursian/projects/my-project/ideas/initial-idea.md
   ```

3. **Run workflows sequentially:**
   - Ideation → Vision
   - Focus Group → Validation
   - Engineering Meeting → PRD
   - Stakeholder Review → Approval

4. **Track progress:**
   - Update `metadata.json` after each workflow
   - Export conversations for documentation
   - Archive session states for resumption

### Workflow-Specific Guides

- [Ideation Flow Guide](./workflows/01-ideation-guide.md)
- [Focus Group Guide](./workflows/02-focus-group-guide.md)
- [Engineering Meeting Guide](./workflows/03-engineering-meeting-guide.md)
- [Stakeholder Review Guide](./workflows/04-stakeholder-review-guide.md)

---

## Templates

### Project Metadata Template

Location: `.thursian/templates/project-metadata.json`

Use this template to initialize new projects. Fill in:
- `project_name`
- `display_name`
- `tags` and `domain`
- `target_audience`

### Session State Template

Location: `.thursian/templates/session-state.json`

Track real-time workflow execution:
- Current state
- Active agents
- Memory operations
- Performance metrics

### Conversation Export Template

Location: `.thursian/templates/conversation-export.md`

Generate comprehensive conversation logs:
- Full transcript
- Round-by-round analysis
- Key insights and decisions
- Performance metrics

---

## Examples

### Example: Pond Conspiracy

A complete example project demonstrating all workflows:

**Location:** `.thursian/projects/pond-conspiracy/`

**Artifacts:**
- Initial Idea: `ideas/initial-idea.md`
- Vision Document: `visions/vision-v1.md`
- Focus Group Report: `focus-groups/report.md`
- PRD: `prds/prd-v1.md`
- Stakeholder Feedback: `prds/stakeholder-feedback.md`

**Status:** Stakeholder Review in progress

---

## Best Practices

### File Naming

- Use `lowercase-with-dashes` for all files
- Version artifacts: `vision-v1.md`, `vision-v2.md`
- Use descriptive names: `prd-approved.md` not `final.md`

### Metadata Management

- Update `metadata.json` after each workflow completion
- Track all artifacts in the `artifacts` section
- Maintain session states for long-running workflows

### Memory Management

- Use project-specific namespaces
- Clean up old memory keys after 90 days
- Export important conversations before cleanup

### Agent Coordination

- Keep personas in workflow-specific directories
- System agents stay in `.thursian/agents/`
- Document custom persona modifications

### Workflow Execution

- Always start with `metadata.json` creation
- Complete workflows before moving to next phase
- Archive session states for resumability
- Export conversations for documentation

---

## Support

For issues or questions:
- Check workflow guides in `./workflows/`
- Review example projects in `./examples/`
- Consult workflow registry: `./workflows/00-metadata.yaml`

---

**Maintained by:** Thursian Development Team
**Documentation Version:** 2.0.0
**Last Updated:** 2025-12-13
