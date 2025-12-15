# Ideation Workflow Guide

**Workflow:** `01-ideation-flow.yaml`
**Version:** 1.0.0
**Estimated Duration:** 20-30 minutes

---

## Overview

The Ideation workflow transforms a rough idea into an exciting, feasible vision document through an 8-round dialectic conversation between two specialized agents:

- **Dreamer**: Expansive thinking, "what if" questions, innovation focus
- **Doer**: Grounded pragmatism, "how can we" solutions, feasibility validation

---

## Inputs

### Required
- **Idea File**: `.thursian/projects/{project-name}/ideas/initial-idea.md`
  - Format: Markdown
  - Length: 1-3 paragraphs
  - Content: Problem statement, target users, core idea

### Example Idea File

```markdown
# TaskFlow - Energy-Aware Task Management

I want to build a task management app that respects how humans work.
Most task apps treat you like a productivity robot, but people have
natural energy patterns throughout the day.

Target users: Knowledge workers, freelancers
Core problem: People know WHAT to do, but struggle with WHEN to do it
```

---

## Outputs

### Primary Artifacts
1. **Vision Document**: `.thursian/projects/{project-name}/visions/vision-v1.md`
   - Length: 1-3 pages
   - Sections: Problem, Solution, MVP Scope, User Impact, Technical Direction

2. **Conversation Log** (in memory):
   - 8 rounds of Dreamer ↔ Doer dialogue
   - Stored in AgentDB namespace: `{project-name}-conversations`

---

## Workflow Structure

### Rounds 1-2: Foundation
- **Focus**: Establish vision and validate feasibility
- **Dreamer**: Expands scope, explores possibilities
- **Doer**: Grounds in reality, structures approach

### Rounds 3-4: Refinement
- **Focus**: User experience and MVP definition
- **Dreamer**: Explores user impact and edge cases
- **Doer**: Defines version 1 scope and features

### Rounds 5-6: Scaling
- **Focus**: Future possibilities and phased rollout
- **Dreamer**: Envisions growth and scaling
- **Doer**: Plans realistic timeline and phases

### Rounds 7-8: Convergence
- **Focus**: Unique value and excitement validation
- **Dreamer**: Questions what makes it special
- **Doer**: Declares "Ah-ha!" moment - ready for validation

---

## Agents

### Dreamer
- **Persona File**: `.thursian/personas/ideation/dreamer.md`
- **Thinking Style**: Expansive, visionary
- **Focuses On**: Possibilities, user impact, innovation, edge cases
- **Asks**: "What if...?", "Imagine if...", "What about...?"

### Doer
- **Persona File**: `.thursian/personas/ideation/doer.md`
- **Thinking Style**: Grounded, pragmatic
- **Focuses On**: Feasibility, structure, MVP, technical reality
- **Asks**: "How can we...?", "Let's start with...", "The MVP would be..."

### Synthesizer
- **Persona File**: `.thursian/personas/ideation/synthesizer.md`
- **Role**: Vision document writer
- **Reads**: All 8 rounds of conversation
- **Outputs**: Structured vision document

---

## Success Criteria

A successful ideation produces:
- ✅ Clear problem statement
- ✅ Exciting solution vision
- ✅ Defined MVP scope
- ✅ Technical feasibility validated
- ✅ User impact articulated
- ✅ Ready for focus group validation

---

## Manual Execution Steps

### Step 1: Prepare Project

```bash
# Create project structure
mkdir -p .thursian/projects/{project-name}/{ideas,visions,sessions}

# Create metadata.json from template
cp .thursian/templates/project-metadata.json .thursian/projects/{project-name}/metadata.json

# Edit metadata with project details
```

### Step 2: Write Initial Idea

Create `.thursian/projects/{project-name}/ideas/initial-idea.md`:

```markdown
# {Project Name}

{1-3 paragraph description}

Target users: {audience}
Core problem: {problem statement}
```

### Step 3: Execute Rounds

For each round (1-8):

**Dreamer Turn:**
```
Task: "You are the Dreamer agent. Read the idea/previous responses and respond
with expansive 'what if' thinking. Focus on possibilities and user impact.
This is Round {N} of 8."
```

**Doer Turn:**
```
Task: "You are the Doer agent. Read the Dreamer's response and respond with
grounded, practical 'how can we' thinking. Validate feasibility and structure.
This is Round {N} of 8."
```

### Step 4: Synthesize Vision

```
Task: "You are the Synthesizer. Read all 8 rounds of conversation between
Dreamer and Doer. Create a 1-3 page vision document following the template
in .thursian/personas/ideation/synthesizer.md. Output to
.thursian/projects/{project-name}/visions/vision-v1.md"
```

### Step 5: Update Metadata

Update `.thursian/projects/{project-name}/metadata.json`:
- Set `ideation.status` to `completed`
- Set `ideation.completed_at` timestamp
- Add vision artifact to `ideation.artifacts`
- Update `current_workflow` to `focus-group`

---

## Tips & Best Practices

### Keep Dreamer Expansive
- Don't let Dreamer become too practical
- Encourage wild ideas that Doer can refine
- "What if" questions should be provocative

### Keep Doer Grounded
- Doer should challenge unrealistic scope
- Must define concrete MVP features
- Should identify technical blockers early

### Ensure Convergence
- By Round 7, both should be aligned
- Round 8 should feel like "we've got it!"
- If not converging, add Round 9

### Vision Document Quality
- Should excite and be feasible simultaneously
- Must have clear MVP scope
- Technical direction should be realistic

---

## Common Issues

### Problem: Agents go off-topic
**Solution**: Add stronger constraints to persona files, remind of project scope

### Problem: Vision is too vague
**Solution**: Give Synthesizer more specific extraction criteria

### Problem: No convergence by Round 8
**Solution**: Add Round 9, or strengthen Doer's feasibility validation

### Problem: Vision is boring
**Solution**: Give Dreamer more freedom to explore innovation

---

## Next Workflow

After successful ideation:
- **Next**: Focus Group (02-focus-group-flow.yaml)
- **Input**: Vision document
- **Purpose**: Validate with user personas
- **Duration**: 30-45 minutes

---

## Example Output Structure

```markdown
# {Project Name} - Vision Document

## The Problem
{Clear problem statement}

## The Solution
{Exciting solution vision}

## Target Users
{User segments and personas}

## MVP Scope
{Version 1 feature set}

## User Impact
{How this changes users' lives}

## Technical Direction
{High-level architecture}

## What Makes This Special
{Unique value proposition}

## Next Steps
{Handoff to focus group}
```

---

**Related Documentation:**
- [Focus Group Guide](./02-focus-group-guide.md)
- [Dreamer Persona](./../personas/ideation/dreamer.md)
- [Doer Persona](./../personas/ideation/doer.md)
- [Synthesizer Persona](./../personas/ideation/synthesizer.md)
