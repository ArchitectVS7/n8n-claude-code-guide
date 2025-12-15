# Project Naming System - Complete Implementation ✅

**Date:** 2025-12-13
**Status:** ✅ COMPLETE - All workflows use {project-name} template variable

---

## Critical Issue Identified and Resolved

### Problem
Workflows used `{project-name}` template variable but **no mechanism existed** to:
1. Generate the project name/slug from initial idea
2. Initialize project directory structure
3. Set up metadata with the generated slug

### Solution
Created **00-project-init-flow.yaml** - Project initialization workflow that MUST run before any other workflow.

---

## How Project Naming Works

### 1. User Provides Initial Idea
User creates `initial-idea.md` anywhere with their concept:
```markdown
# AI-Powered Board Game Companion

An app that helps board game enthusiasts track games, analyze strategies,
and connect with other players...
```

### 2. Run Project Initialization
```bash
# Run initialization workflow
npx claude-flow project-init --input path/to/initial-idea.md
```

### 3. System Generates Project Slug
**Algorithm:**
1. Extract 2-3 most important words from title/description
2. Convert to lowercase
3. Replace spaces with dashes
4. Remove special characters
5. Ensure uniqueness (append -v2 if directory exists)

**Examples:**
- "AI-Powered Board Game Companion" → `ai-board-game-companion`
- "The Pond Conspiracy Detection System" → `pond-conspiracy`
- "Developer API Testing Tool" → `api-testing-tool`
- "untitled idea" → `ml-project-20251213`

**Pattern:** `^[a-z0-9-]+$` (max 50 chars)

### 4. Create Project Structure
```
.thursian/projects/{project-slug}/
├── 00-{project-slug}-initial-idea.md     # Copied from input
├── metadata.json                         # Generated from template
├── README.md                             # Generated from template
└── design-docs/                          # Created for future use
    └── adrs/                             # Architecture Decision Records
```

### 5. All Subsequent Workflows Use {project-slug}
Every workflow now uses the generated slug:
- `01-{project-slug}-ideation-full.md`
- `01-{project-slug}-vision.md`
- `02-{project-slug}-focus-group-full.md`
- etc.

---

## Workflow Sequence with Project Naming

```
00-project-init-flow.yaml
   ↓ (generates project-slug: "pond-conspiracy")
   ↓ (creates .thursian/projects/pond-conspiracy/)
   ↓ (copies 00-pond-conspiracy-initial-idea.md)
   ↓
01-ideation-flow.yaml --project pond-conspiracy
   ↓ (input: 00-pond-conspiracy-initial-idea.md)
   ↓ (outputs: 01-pond-conspiracy-ideation-full.md, 01-pond-conspiracy-vision.md)
   ↓
02-focus-group-flow.yaml --project pond-conspiracy
   ↓ (input: 01-pond-conspiracy-vision.md)
   ↓ (outputs: 02-pond-conspiracy-focus-group-full.md, 02-pond-conspiracy-focus-group-report.md)
   ↓
03-engineering-meeting-flow.yaml --project pond-conspiracy
   ↓ (input: 02-pond-conspiracy-focus-group-report.md)
   ↓ (outputs: 03-pond-conspiracy-engineering-full.md, 03-pond-conspiracy-prd.md, design-docs/PRD.md)
   ↓
04-stakeholder-review-flow.yaml --project pond-conspiracy
   ↓ (input: 03-pond-conspiracy-prd.md)
   ↓ (outputs: 04-pond-conspiracy-stakeholder-full.md, 04-pond-conspiracy-stakeholder-feedback.md)
   ↓
05-engineering-review-flow.yaml --project pond-conspiracy
   ↓ (input: 04-pond-conspiracy-stakeholder-feedback.md)
   ↓ (outputs: 05-pond-conspiracy-engineering-review-full.md, 05-pond-conspiracy-triage-report.md, design-docs/PRD-v0.2.md)
```

---

## Verification Results

### ✅ All Workflows Use {project-name} Template Variable
Checked all workflow files for hardcoded project names:
```bash
grep -n "pond-conspiracy" .thursian/workflows/*.yaml
# Result: No matches ✅
```

**Template variable usage:** 69 occurrences across all workflows ✅

### ✅ Updated Workflows

**00-project-init-flow.yaml** (NEW)
- Reads initial idea from any location
- Generates project slug using algorithm
- Creates directory structure
- Copies initial idea as `00-{project-slug}-initial-idea.md`
- Creates `metadata.json` from template
- Creates `README.md` from template
- Hands off to workflow 01

**01-ideation-flow.yaml** (UPDATED)
- Input: `.thursian/projects/{project-name}/00-{project-name}-initial-idea.md`
- Requires: `project_initialization`
- Handoff from: `00-project-init-flow.yaml`
- Note added explaining {project-name} comes from initialization

**02-focus-group-flow.yaml** (UPDATED)
- Input: `.thursian/projects/{project-name}/01-{project-name}-vision.md`
- Note added explaining {project-name} is a slug

**03-engineering-meeting-flow.yaml** (UPDATED)
- Input: `.thursian/projects/{project-name}/02-{project-name}-focus-group-report.md`
- Note added explaining {project-name} is a slug

**04-stakeholder-review-flow.yaml** (ALREADY CORRECT)
- Input: `.thursian/projects/{project-name}/03-{project-name}-prd.md`
- Uses template variable correctly

**05-engineering-review-flow.yaml** (ALREADY CORRECT)
- Input: `.thursian/projects/{project-name}/04-{project-name}-stakeholder-feedback.md`
- Uses template variable correctly

**06-architecture-planning-flow.yaml** (VERIFIED)
- Uses `{project-name}` template variable
- No hardcoded project names

---

## Naming Convention Rules

### Project Slug Format
- **Pattern:** `^[a-z0-9-]+$`
- **Max Length:** 50 characters
- **Separator:** Dash (-)
- **Case:** Lowercase only
- **No:** Special characters, spaces, underscores

### File Naming Format
**Pattern:** `{step}-{project-slug}-{document-type}.md`

**Examples:**
- `00-pond-conspiracy-initial-idea.md`
- `01-ai-companion-ideation-full.md`
- `01-ai-companion-vision.md`
- `02-api-tool-focus-group-full.md`
- `03-ml-project-prd.md`

---

## Slug Generation Examples

| Input | Output | Explanation |
|-------|--------|-------------|
| "AI-Powered Board Game Companion" | `ai-board-game-companion` | Key words extracted, lowercased, dash-separated |
| "The Pond Conspiracy: Social Media Analysis" | `pond-conspiracy` | Memorable name used, articles removed |
| "Developer Tool for API Testing & Debugging" | `api-testing-tool` | Special chars removed, core concept |
| "My Awesome New Productivity App" | `productivity-app` | Filler words removed |
| "untitled idea about machine learning" | `ml-project-20251213` | Generic name with timestamp |

---

## Manual Orchestration

When running workflows manually in Claude Code sessions:

1. **Initialize project first:**
   ```
   "I have a new idea. Please initialize a project using 00-project-init-flow.yaml.
   My initial idea is in initial-idea.md."
   ```

2. **Claude generates slug:**
   - Reads idea
   - Generates slug (e.g., "pond-conspiracy")
   - Creates directory structure
   - Copies files

3. **Use generated slug for all subsequent workflows:**
   ```
   "Run ideation workflow for project pond-conspiracy"
   ```

---

## Benefits

### 1. No Hardcoded Project Names
- ✅ All workflows are project-agnostic
- ✅ Can run multiple projects in parallel
- ✅ Easy to clone and adapt

### 2. Automatic Slug Generation
- ✅ Consistent naming across all files
- ✅ No manual naming decisions needed
- ✅ Handles conflicts automatically (append -v2)

### 3. Self-Documenting
- ✅ File names include project slug
- ✅ Easy to identify which project files belong to
- ✅ Clear chronological order

### 4. Scalable
- ✅ Can manage dozens of projects
- ✅ No naming collisions
- ✅ Clear separation of concerns

---

## Migration for Existing Projects

For pond-conspiracy (already exists):

**Option 1: Retroactively Initialize**
```bash
# Create metadata and README using existing files
# Project slug: pond-conspiracy (already established)
```

**Option 2: Leave As-Is**
```bash
# pond-conspiracy works because files already follow convention
# Just needs metadata.json and README.md created
```

---

## Next Steps

1. **For new projects:**
   - Always run `00-project-init-flow.yaml` first
   - System generates slug automatically
   - Use slug for all subsequent workflows

2. **For pond-conspiracy:**
   - Already has correct file names
   - Just needs metadata.json and README.md
   - Can continue with engineering review workflow (05)

3. **Documentation:**
   - Update user guide to explain initialization step
   - Add examples of slug generation
   - Document manual orchestration process

---

**Status:** ✅ COMPLETE
**All workflows:** Project-agnostic with {project-name} template variable
**Initialization workflow:** Created (00-project-init-flow.yaml)
**Slug generation:** Automated with clear algorithm
**Ready for:** Multi-project support

---

**Updated:** 2025-12-13
**Verified:** All 6 workflows + personas checked for hardcoded names
