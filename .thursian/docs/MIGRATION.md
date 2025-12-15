# Migration Guide: Old Structure → New Structure

**Date:** 2025-12-13
**Version:** 2.0.0

This document explains the file reorganization and how to migrate existing projects.

---

## What Changed

### Directory Structure

**Old Structure:**
```
.thursian/
├── ideation/
│   ├── 02-ideation-flow.yaml
│   ├── 03-focus-group-flow.yaml
│   ├── 04-engineering-meeting-flow.yaml
│   ├── 05-stakeholder-review-flow.yaml
│   ├── agents/
│   ├── ideas/
│   ├── visions/
│   ├── focus-groups/
│   ├── prds/
│   └── conversations/
├── agents/
└── thursian-flow.yaml
```

**New Structure:**
```
.thursian/
├── workflows/              # ← All workflow definitions
│   ├── 00-metadata.yaml   # ← NEW: Registry
│   ├── 01-ideation-flow.yaml
│   ├── 02-focus-group-flow.yaml
│   ├── 03-engineering-meeting-flow.yaml
│   └── 04-stakeholder-review-flow.yaml
├── agents/                 # ← System agents only
├── personas/               # ← NEW: Workflow personas
│   ├── ideation/
│   ├── focus-group/
│   ├── engineering/
│   └── stakeholder/
├── projects/               # ← NEW: Project-centric
│   └── {project-name}/
│       ├── metadata.json   # ← NEW: Project metadata
│       ├── ideas/
│       ├── visions/
│       ├── focus-groups/
│       ├── prds/
│       └── sessions/       # ← NEW: Session tracking
├── templates/              # ← NEW: Reusable templates
└── docs/                   # ← NEW: Documentation
```

---

## Key Changes

### 1. Workflow Files Consolidated & Renumbered

| Old Location | New Location | Notes |
|-------------|-------------|-------|
| `.thursian/ideation/02-ideation-flow.yaml` | `.thursian/workflows/01-ideation-flow.yaml` | Renumbered |
| `.thursian/ideation/03-focus-group-flow.yaml` | `.thursian/workflows/02-focus-group-flow.yaml` | Renumbered |
| `.thursian/ideation/04-engineering-meeting-flow.yaml` | `.thursian/workflows/03-engineering-meeting-flow.yaml` | Renumbered |
| `.thursian/ideation/05-stakeholder-review-flow.yaml` | `.thursian/workflows/04-stakeholder-review-flow.yaml` | Renumbered |

**Why:**
- All workflows in one location
- Consistent numbering (01, 02, 03...)
- Added master registry (00-metadata.yaml)

### 2. Agents vs Personas Separated

**System Agents** (`.thursian/agents/`):
- Orchestrator
- Planner
- Developer
- Reviewer
- Executive Proxy

**Workflow Personas** (`.thursian/personas/`):
- Ideation: Dreamer, Doer, Synthesizer
- Focus Group: Facilitator, Researcher
- Engineering: Technical Lead, Product Manager, etc.
- Stakeholder: Engineering Manager

**Why:**
- Clear separation of concerns
- Easier to find and modify personas
- System agents are reusable across workflows

### 3. Project-Centric Organization

All project artifacts now live in:
```
.thursian/projects/{project-name}/
```

**Benefits:**
- All project files in one place
- Easy to archive/share entire project
- Metadata tracking per project
- Session state persistence

### 4. New Files Added

- `workflows/00-metadata.yaml` - Master workflow registry
- `projects/{project}/metadata.json` - Project tracking
- `templates/project-metadata.json` - Project template
- `templates/session-state.json` - Session tracking template
- `templates/conversation-export.md` - Conversation export template
- `docs/README.md` - Documentation index
- `docs/workflows/*.md` - Workflow guides

---

## Migration Steps

### For Existing Projects (e.g., pond-conspiracy)

#### Step 1: Verify Old Files Exist

```bash
# Check current pond-conspiracy files
ls -la .thursian/ideation/ideas/pond-conspiracy.md
ls -la .thursian/ideation/visions/pond-conspiracy-vision.md
ls -la .thursian/ideation/focus-groups/pond-conspiracy-focus-group.md
ls -la .thursian/ideation/prds/pond-conspiracy-prd.md
```

#### Step 2: Files Already Migrated

The reorganization script already copied files to:
```
.thursian/projects/pond-conspiracy/
├── ideas/initial-idea.md
├── visions/vision-v1.md
├── focus-groups/
│   ├── report.md
│   └── conversations/full-transcript.md
└── prds/
    ├── prd-v1.md
    └── stakeholder-feedback.md
```

#### Step 3: Create Project Metadata

Already created at:
```
.thursian/projects/pond-conspiracy/metadata.json
```

Contains:
- Workflow status tracking
- Artifact locations
- Memory namespace configuration
- Performance metrics

#### Step 4: Verify Migration

```bash
# Check new structure
ls -la .thursian/projects/pond-conspiracy/
cat .thursian/projects/pond-conspiracy/metadata.json
```

---

## For New Projects

### Quick Start

1. **Create project directory:**
   ```bash
   PROJECT_NAME="my-new-project"
   mkdir -p .thursian/projects/$PROJECT_NAME/{ideas,visions,focus-groups/conversations,prds,sessions}
   ```

2. **Copy metadata template:**
   ```bash
   cp .thursian/templates/project-metadata.json .thursian/projects/$PROJECT_NAME/metadata.json
   ```

3. **Edit metadata:**
   - Set `project_name`
   - Set `display_name`
   - Add `tags` and `domain`
   - Configure `target_audience`

4. **Write initial idea:**
   ```bash
   vim .thursian/projects/$PROJECT_NAME/ideas/initial-idea.md
   ```

5. **Run workflows sequentially**

---

## Breaking Changes

### Path References in Workflow Files

**Action Required:** Workflow files may need path updates if they reference old locations.

**Before:**
```yaml
path_template: .thursian/ideation/ideas/{idea-id}.md
```

**After:**
```yaml
path_template: .thursian/projects/{project-name}/ideas/initial-idea.md
```

**Status:** Workflow files have NOT been updated yet. Will need updates when running workflows.

### Persona File References

**Before:**
```yaml
persona_file: .thursian/ideation/agents/dreamer.md
```

**After:**
```yaml
persona_file: .thursian/personas/ideation/dreamer.md
```

**Status:** Need to update workflow YAML files to reference new persona locations.

---

## Backward Compatibility

### Old Files Preserved

The migration is NON-DESTRUCTIVE. Old files are still in:
```
.thursian/ideation/
```

**Recommendation:** Keep old files for reference during transition, delete after validation.

### Workflow Files

Old workflow files still exist in:
```
.thursian/ideation/02-ideation-flow.yaml (etc.)
```

New files in:
```
.thursian/workflows/01-ideation-flow.yaml (etc.)
```

**Next Step:** Update workflow YAML files to use new paths.

---

## Validation Checklist

After migration, verify:

- [ ] All workflow files in `.thursian/workflows/`
- [ ] Master registry exists: `workflows/00-metadata.yaml`
- [ ] Personas separated into `.thursian/personas/{workflow}/`
- [ ] System agents in `.thursian/agents/`
- [ ] Project artifacts in `.thursian/projects/{project-name}/`
- [ ] Project metadata exists and is valid
- [ ] Templates available in `.thursian/templates/`
- [ ] Documentation in `.thursian/docs/`
- [ ] Old files still accessible (for reference)

---

## Next Steps

1. **Update workflow YAML files** to reference new paths
2. **Test workflows** with new structure
3. **Archive old files** once validated
4. **Document custom modifications** to personas
5. **Create session states** for active workflows

---

## Rollback Plan

If issues arise:

1. Old files are preserved in `.thursian/ideation/`
2. Revert to old structure by using original workflow files
3. Report issues for troubleshooting

**Note:** New files (metadata, templates, docs) can coexist with old structure.

---

## Questions?

Refer to:
- [Documentation Index](./../docs/README.md)
- [Workflow Registry](./../workflows/00-metadata.yaml)
- [Workflow Guides](./../docs/workflows/)
