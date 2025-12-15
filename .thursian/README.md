# Thursian Workflow System

**Version:** 2.0.0
**Last Updated:** 2025-12-13

---

## Quick Start

### For New Projects

1. **Create project structure:**
   ```bash
   PROJECT="my-project"
   mkdir -p .thursian/projects/$PROJECT/{ideas,visions,focus-groups/conversations,prds,sessions}
   cp .thursian/templates/project-metadata.json .thursian/projects/$PROJECT/metadata.json
   ```

2. **Write your idea:**
   ```bash
   vim .thursian/projects/$PROJECT/ideas/initial-idea.md
   ```

3. **Run workflows:**
   - Ideation → Vision (20-30 min)
   - Focus Group → Validation (30-45 min)
   - Engineering Meeting → PRD (45-60 min)
   - Stakeholder Review → Approval (60-90 min)

---

## Directory Structure

```
.thursian/
├── workflows/              # All workflow definitions
│   ├── 00-metadata.yaml   # Master registry
│   ├── 01-ideation-flow.yaml
│   ├── 02-focus-group-flow.yaml
│   ├── 03-engineering-meeting-flow.yaml
│   └── 04-stakeholder-review-flow.yaml
│
├── agents/                 # System-level agents
│   ├── orchestrator.md
│   ├── planner.md
│   ├── developer.md
│   ├── reviewer.md
│   └── executive-proxy.md
│
├── personas/               # Workflow-specific personas
│   ├── ideation/
│   ├── focus-group/
│   ├── engineering/
│   └── stakeholder/
│
├── projects/               # Per-project workspaces
│   └── {project-name}/
│       ├── metadata.json  # Project tracking
│       ├── ideas/
│       ├── visions/
│       ├── focus-groups/
│       ├── prds/
│       └── sessions/
│
├── templates/              # Reusable templates
│   ├── project-metadata.json
│   ├── session-state.json
│   └── conversation-export.md
│
└── docs/                   # Documentation
    ├── README.md
    ├── MIGRATION.md
    └── workflows/
```

---

## Active Projects

### Pond Conspiracy
**Status:** Stakeholder Review
**Location:** `.thursian/projects/pond-conspiracy/`
**Artifacts:**
- ✅ Initial Idea
- ✅ Vision Document
- ✅ Focus Group Report
- ✅ PRD v1
- 🔄 Stakeholder Feedback (in progress)

---

## Workflows

| ID | Name | Status | Duration |
|----|------|--------|----------|
| 01 | Ideation: Dreamer ↔ Doer | ✅ Active | 20-30 min |
| 02 | Focus Group: Multi-Persona | ✅ Active | 30-45 min |
| 03 | Engineering Meeting: PRD | ✅ Active | 45-60 min |
| 04 | Stakeholder Review | ✅ Active | 60-90 min |
| 05 | Technical Design | 📋 Planned | 60-90 min |

**Full Registry:** [workflows/00-metadata.yaml](./workflows/00-metadata.yaml)

---

## Documentation

- **Getting Started:** [docs/README.md](./docs/README.md)
- **Migration Guide:** [docs/MIGRATION.md](./docs/MIGRATION.md)
- **Workflow Guides:** [docs/workflows/](./docs/workflows/)

### Quick Links

- [Ideation Guide](./docs/workflows/01-ideation-guide.md)
- [Workflow Registry](./workflows/00-metadata.yaml)
- [Project Metadata Template](./templates/project-metadata.json)
- [Session State Template](./templates/session-state.json)

---

## Templates

### Create New Project
```bash
cp .thursian/templates/project-metadata.json .thursian/projects/NEW_PROJECT/metadata.json
```

### Track Session State
```bash
cp .thursian/templates/session-state.json .thursian/projects/PROJECT/sessions/SESSION_ID.json
```

### Export Conversation
Use template: `.thursian/templates/conversation-export.md`

---

## File Organization Standards

### Naming Conventions
- Projects: `lowercase-with-dashes`
- Files: `descriptive-lowercase-with-dashes`
- Versions: `v{major}.{minor}.{patch}`
- Sessions: `{workflow}-{timestamp}`

### Required Files Per Project
- `metadata.json` - Project tracking
- `ideas/initial-idea.md` - Starting point
- `sessions/*.json` - Session states (for long workflows)

### Artifact Organization
- Ideas → `ideas/`
- Visions → `visions/`
- Focus Groups → `focus-groups/`
- PRDs → `prds/`
- Technical Docs → `technical/`
- Session States → `sessions/`

---

## Memory Configuration

**Backend:** AgentDB
**Persistence:** Enabled
**Retention:** 90 days
**Namespace Format:** `thursian/{project-name}/{workflow-id}`

### Namespaces Used
- `{project}-conversations`
- `{project}-visions`
- `{project}-ideas`
- `{project}-personas`
- `{project}-discussions`
- `{project}-research`
- `{project}-prds`
- `{project}-feedback`

---

## Integration

### Claude Flow
```bash
npx claude-flow@alpha swarm init --topology mesh --agents 7
npx claude-flow@alpha task orchestrate --task "Run workflow"
```

### N8N (Planned)
See: [Integration manifest planning document]

### Continuous Claude (For Implementation)
```bash
npx continuous-claude --task "Implement PRD" --until-pr
```

---

## Changelog

### Version 2.0.0 (2025-12-13)
- ✅ Reorganized file structure
- ✅ Added workflow registry (00-metadata.yaml)
- ✅ Separated agents from personas
- ✅ Created project-centric organization
- ✅ Added metadata tracking templates
- ✅ Created comprehensive documentation
- ✅ Migrated pond-conspiracy project

### Version 1.0.0
- Initial workflow definitions
- Basic ideation, focus-group, engineering, stakeholder flows
- Agent personas created

---

## Support

**Documentation:** [docs/README.md](./docs/README.md)
**Workflow Registry:** [workflows/00-metadata.yaml](./workflows/00-metadata.yaml)
**Migration Guide:** [docs/MIGRATION.md](./docs/MIGRATION.md)

---

**Maintained by:** Thursian Development Team
