# {{project-name}} - Project Status

**Status:** {{status}}
**Current Workflow:** {{current-workflow}}
**Started:** {{start-date}}
**Last Updated:** {{last-updated}}

---

## Project Overview

{{project-description}}

**Domain:** {{domain}}
**Type:** {{project-type}}

---

## Workflow Progress

### ✅ Completed Workflows

#### 00 - Initial Idea
- **Input:** [00-{{project-name}}-initial-idea.md](./00-{{project-name}}-initial-idea.md)
- **Status:** ✅ Complete
- **Date:** {{00-completion-date}}

#### 01 - Ideation (Dreamer ↔ Doer Dialectic)
- **Conversation:** [01-{{project-name}}-ideation-full.md](./01-{{project-name}}-ideation-full.md)
- **Output:** [01-{{project-name}}-vision.md](./01-{{project-name}}-vision.md)
- **Status:** {{01-status}}
- **Date:** {{01-completion-date}}
- **Key Outcomes:**
  - {{01-outcome-1}}
  - {{01-outcome-2}}
  - {{01-outcome-3}}

#### 02 - Focus Group (User Validation)
- **Conversation:** [02-{{project-name}}-focus-group-full.md](./02-{{project-name}}-focus-group-full.md)
- **Output:** [02-{{project-name}}-focus-group-report.md](./02-{{project-name}}-focus-group-report.md)
- **Status:** {{02-status}}
- **Date:** {{02-completion-date}}
- **Key Outcomes:**
  - {{02-outcome-1}}
  - {{02-outcome-2}}
  - {{02-outcome-3}}

#### 03 - Engineering Meeting (PRD Creation)
- **Conversation:** [03-{{project-name}}-engineering-full.md](./03-{{project-name}}-engineering-full.md)
- **Output:** [03-{{project-name}}-prd.md](./03-{{project-name}}-prd.md)
- **Design Doc:** [design-docs/PRD.md](./design-docs/PRD.md)
- **Status:** {{03-status}}
- **Date:** {{03-completion-date}}
- **Key Outcomes:**
  - {{03-outcome-1}}
  - {{03-outcome-2}}
  - {{03-outcome-3}}

#### 04 - Stakeholder Review (PRD Validation)
- **Conversation:** [04-{{project-name}}-stakeholder-full.md](./04-{{project-name}}-stakeholder-full.md)
- **Output:** [04-{{project-name}}-stakeholder-feedback.md](./04-{{project-name}}-stakeholder-feedback.md)
- **Approved PRD:** [design-docs/PRD-approved.md](./design-docs/PRD-approved.md)
- **Status:** {{04-status}}
- **Date:** {{04-completion-date}}
- **Key Outcomes:**
  - {{04-outcome-1}}
  - {{04-outcome-2}}
  - {{04-outcome-3}}

### 🔄 In Progress

{{in-progress-workflow}}

### 📋 Pending Workflows

#### 05 - Technical Design (System Architecture)
- **Status:** Pending
- **Depends On:** Approved PRD from Stakeholder Review
- **Expected Outputs:**
  - Conversation transcript
  - Technical design document
  - Architecture diagrams

---

## Design Documents

All finalized design documents are stored in [`design-docs/`](./design-docs/):

| Document | Version | Status | Last Updated |
|----------|---------|--------|--------------|
| [PRD.md](./design-docs/PRD.md) | v{{prd-version}} | {{prd-status}} | {{prd-date}} |
| [PRD-approved.md](./design-docs/PRD-approved.md) | v{{prd-approved-version}} | {{prd-approved-status}} | {{prd-approved-date}} |
| Technical Design | - | Pending | - |
| Architecture Diagram | - | Pending | - |

---

## Historical Artifacts

All workflow conversations and inline documents are stored in the main project directory for historical review:

### Conversations (Full Transcripts)
- `01-{{project-name}}-ideation-full.md` - Complete ideation dialogue
- `02-{{project-name}}-focus-group-full.md` - Complete focus group discussion
- `03-{{project-name}}-engineering-full.md` - Complete engineering meeting
- `04-{{project-name}}-stakeholder-full.md` - Complete stakeholder review

### Inline Documents (Point-in-Time Outputs)
- `01-{{project-name}}-vision.md` - Vision document from ideation
- `02-{{project-name}}-focus-group-report.md` - Focus group findings
- `03-{{project-name}}-prd.md` - Initial PRD from engineering meeting
- `04-{{project-name}}-stakeholder-feedback.md` - Stakeholder feedback and revisions

---

## Next Steps

{{next-steps}}

---

## Metadata

**Project ID:** {{project-id}}
**Workflow Version:** {{workflow-version}}
**Repository:** {{repository-url}}
**Team:** {{team-members}}

---

**Last Updated:** {{last-updated}}
**Status Updated By:** {{updated-by}}
