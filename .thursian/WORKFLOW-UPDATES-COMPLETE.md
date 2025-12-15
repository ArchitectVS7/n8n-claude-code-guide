# Workflow File Updates Complete ✅

**Date:** 2025-12-13
**Status:** ✅ ALL WORKFLOW FILES UPDATED

---

## Summary

Updated all 4 workflow YAML files to implement linear document flow with dual outputs:
1. **Full conversation transcript** - Complete round-by-round discussion
2. **Output document** - Synthesized artifact from that workflow

This creates a clear historical record while maintaining clean design documents.

---

## Naming Convention Implemented

All outputs follow the pattern: `[step]-[project-name]-[document-type].md`

### Examples (pond-conspiracy project):
- `00-pond-conspiracy-initial-idea.md` - Input
- `01-pond-conspiracy-ideation-full.md` - Conversation
- `01-pond-conspiracy-vision.md` - Vision output
- `02-pond-conspiracy-focus-group-full.md` - Conversation
- `02-pond-conspiracy-focus-group-report.md` - Report output
- `03-pond-conspiracy-engineering-full.md` - Conversation
- `03-pond-conspiracy-prd.md` - PRD inline version
- `04-pond-conspiracy-stakeholder-full.md` - Conversation
- `04-pond-conspiracy-stakeholder-feedback.md` - Feedback output

### Design Documents:
- `design-docs/PRD.md` - Official PRD
- `design-docs/PRD-approved.md` - Approved PRD

---

## Updated Files

### 1. 01-ideation-flow.yaml

**Changes Made:**
- ✅ Updated `output_contract` to include dual outputs
- ✅ Updated `synthesize_vision` state to export conversation + vision
- ✅ Conversation: `01-{project-name}-ideation-full.md`
- ✅ Vision: `01-{project-name}-vision.md`

**Key Code:**
```yaml
output_contract:
  - type: conversation_transcript
    path_template: .thursian/projects/{project-name}/01-{project-name}-ideation-full.md
  - type: vision_document
    path_template: .thursian/projects/{project-name}/01-{project-name}-vision.md

synthesize_vision:
  actions:
    - type: export_conversation
      format: full_transcript
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/01-{project-name}-ideation-full.md
    - type: synthesize
      format: vision_document
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/01-{project-name}-vision.md
```

---

### 2. 02-focus-group-flow.yaml

**Changes Made:**
- ✅ Updated `output_contract` to include dual outputs
- ✅ Updated `synthesize_focus_group` state to export conversation + report
- ✅ Conversation: `02-{project-name}-focus-group-full.md`
- ✅ Report: `02-{project-name}-focus-group-report.md`

**Key Code:**
```yaml
output_contract:
  - type: conversation_transcript
    path_template: .thursian/projects/{project-name}/02-{project-name}-focus-group-full.md
  - type: focus_group_report
    path_template: .thursian/projects/{project-name}/02-{project-name}-focus-group-report.md

synthesize_focus_group:
  actions:
    - type: export_conversation
      format: full_transcript
      include: [all_rounds, persona_names, research_alignment_notes]
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/02-{project-name}-focus-group-full.md
    - type: synthesize
      format: focus_group_report
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/02-{project-name}-focus-group-report.md
```

---

### 3. 03-engineering-meeting-flow.yaml

**Changes Made:**
- ✅ Updated `output_contract` to include triple outputs (conversation + inline PRD + design doc PRD)
- ✅ Updated `synthesize_prd` state to export all three documents
- ✅ Conversation: `03-{project-name}-engineering-full.md`
- ✅ PRD (inline): `03-{project-name}-prd.md`
- ✅ PRD (design doc): `design-docs/PRD.md`

**Key Code:**
```yaml
output_contract:
  - type: conversation_transcript
    path_template: .thursian/projects/{project-name}/03-{project-name}-engineering-full.md
  - type: prd_inline
    path_template: .thursian/projects/{project-name}/03-{project-name}-prd.md
    description: "Historical inline version"
  - type: prd_design_doc
    path_template: .thursian/projects/{project-name}/design-docs/PRD.md
    description: "Official design document"

synthesize_prd:
  actions:
    - type: export_conversation
      format: full_transcript
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/03-{project-name}-engineering-full.md
    - type: synthesize
      format: product_requirements_document
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/03-{project-name}-prd.md
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/design-docs/PRD.md
```

---

### 4. 04-stakeholder-review-flow.yaml

**Changes Made:**
- ✅ Updated `input` path to use new PRD naming: `03-{project-name}-prd.md`
- ✅ Updated `output_contract` to include triple outputs
- ✅ Updated `synthesize_all_feedback` state to export conversation + feedback
- ✅ Updated `prd_approved` state to write to design-docs
- ✅ Conversation: `04-{project-name}-stakeholder-full.md`
- ✅ Feedback: `04-{project-name}-stakeholder-feedback.md`
- ✅ Approved PRD: `design-docs/PRD-approved.md`

**Key Code:**
```yaml
input:
  path_template: .thursian/projects/{project-name}/03-{project-name}-prd.md

output_contract:
  - type: conversation_transcript
    path_template: .thursian/projects/{project-name}/04-{project-name}-stakeholder-full.md
  - type: stakeholder_feedback
    path_template: .thursian/projects/{project-name}/04-{project-name}-stakeholder-feedback.md
  - type: prd_approved
    path_template: .thursian/projects/{project-name}/design-docs/PRD-approved.md

synthesize_all_feedback:
  actions:
    - type: export_conversation
      format: full_transcript
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/04-{project-name}-stakeholder-full.md
    - type: synthesize
      format: stakeholder_feedback_report
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/04-{project-name}-stakeholder-feedback.md

prd_approved:
  actions:
    - type: create_approved_prd
    - type: filesystem.write
      path_template: .thursian/projects/{project-name}/design-docs/PRD-approved.md
```

---

## Project Structure After Updates

```
.thursian/projects/{project-name}/
├── 00-{project-name}-initial-idea.md           # Input
│
├── 01-{project-name}-ideation-full.md          # Conversation
├── 01-{project-name}-vision.md                 # Output
│
├── 02-{project-name}-focus-group-full.md       # Conversation
├── 02-{project-name}-focus-group-report.md     # Output
│
├── 03-{project-name}-engineering-full.md       # Conversation
├── 03-{project-name}-prd.md                    # Output (inline)
│
├── 04-{project-name}-stakeholder-full.md       # Conversation
├── 04-{project-name}-stakeholder-feedback.md   # Output
│
└── design-docs/                                # Design Documents
    ├── PRD.md                                  # Official PRD
    └── PRD-approved.md                         # Approved PRD
```

---

## Benefits of New Structure

### 1. Linear Document Flow
- ✅ Files numbered in sequential order (00, 01, 02, 03, 04)
- ✅ Easy to review chronologically
- ✅ Clear progression from idea → vision → validation → PRD → approval

### 2. Complete Historical Record
- ✅ Full conversation transcripts preserved
- ✅ Can review exact discussions that led to decisions
- ✅ Audit trail for entire ideation → approval process

### 3. Clean Design Documents
- ✅ `design-docs/` contains only official artifacts
- ✅ PRD versions clearly separated (draft vs approved)
- ✅ Design docs are the source of truth for build phase

### 4. Easy to Navigate
- ✅ Consistent naming pattern across all files
- ✅ File names self-document their purpose
- ✅ Project name always included for multi-project repos

### 5. Better Review Process
- ✅ Stakeholders can review conversations separately from docs
- ✅ Historical inline versions show evolution
- ✅ Design docs remain clean and authoritative

---

## Template Created

**File:** `.thursian/templates/project-README.md`

Master README template for project status tracking with:
- ✅ Workflow progress tracker
- ✅ Links to all conversation and output files
- ✅ Design document index
- ✅ Next steps and pending workflows
- ✅ Metadata and team information

**Usage:** Copy and populate for each new project

---

## Migration Notes for Pond Conspiracy

Current files should be renamed to match new convention:
- `02-focus-group.md` → `02-pond-conspiracy-focus-group-report.md`
- `03-pond-conspiracy-prd-draft.md` → `03-pond-conspiracy-prd.md`
- `04-pond-conspiracy-stakeholder-prd-comments.md` → `04-pond-conspiracy-stakeholder-feedback.md`

PRD in design-docs should be copied from inline version:
- `03-pond-conspiracy-prd.md` → `design-docs/PRD.md`

---

## Next Steps

1. ✅ Create master README for pond-conspiracy project
2. ✅ Rename existing files to match new convention
3. ✅ Copy PRD to design-docs folder
4. ✅ Continue stakeholder review workflow

---

**Status:** ✅ COMPLETE
**Updated:** 2025-12-13
**Updated By:** Workflow standardization process
