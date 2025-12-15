# {{Workflow Name}} - Full Conversation Export

**Project:** {{project-name}}
**Date:** {{date}}
**Session ID:** {{session-id}}
**Workflow:** {{workflow-name}} ({{workflow-file}})
**Status:** {{final-status}}

---

## Session Metadata

| Field | Value |
|-------|-------|
| **Project Name** | {{project-name}} |
| **Display Name** | {{project-display-name}} |
| **Workflow** | {{workflow-name}} |
| **Workflow Version** | {{workflow-version}} |
| **Session ID** | {{session-id}} |
| **Started At** | {{start-timestamp}} |
| **Completed At** | {{end-timestamp}} |
| **Duration** | {{duration-minutes}} minutes |
| **Total Rounds** | {{total-rounds}} |
| **Final Status** | {{final-status}} |

---

## Participants

### Agents
{{#each agents}}
- **{{name}}** ({{role}}) - {{persona-file}}
{{/each}}

### Configuration
- **Domain:** {{domain}}
- **Execution Mode:** {{execution-mode}}
- **Memory Backend:** {{memory-backend}}
- **Memory Namespace:** {{memory-namespace}}

---

## Conversation Flow

{{#each rounds}}
### Round {{round-number}}: {{round-title}}

**State:** {{state-name}}
**Timestamp:** {{timestamp}}
**Duration:** {{duration-seconds}}s

{{#each agents}}
#### {{agent-name}} ({{agent-role}})

{{agent-response}}

**Metadata:**
- Memory Key: `{{memory-key}}`
- Word Count: {{word-count}}
- Sentiment: {{sentiment}}

---

{{/each}}

**Round Summary:**
- {{round-summary}}
- **Key Insights:** {{key-insights}}
- **Decisions Made:** {{decisions}}

---

{{/each}}

---

## Synthesis & Analysis

### Key Insights Across All Rounds

{{#each key-insights}}
- **{{insight-category}}:** {{insight-description}}
{{/each}}

### Decisions Made

{{#each decisions}}
- **{{decision-type}}:** {{decision-description}}
  - Round: {{round-number}}
  - Participants: {{participants}}
  - Rationale: {{rationale}}
{{/each}}

### Recurring Themes

{{#each themes}}
- **{{theme-name}}:** Mentioned {{mention-count}} times
  - Rounds: {{round-numbers}}
  - Context: {{theme-context}}
{{/each}}

### Evolution of Ideas

{{#each idea-evolution}}
- **{{idea-name}}:**
  - Initial State (Round {{start-round}}): {{initial-state}}
  - Final State (Round {{end-round}}): {{final-state}}
  - Key Transformations: {{transformations}}
{{/each}}

---

## Artifacts Generated

{{#each artifacts}}
- **{{artifact-name}}**
  - Type: {{artifact-type}}
  - Path: `{{artifact-path}}`
  - Generated At: {{timestamp}}
  - Size: {{file-size}}
  - Status: {{status}}
{{/each}}

---

## Performance Metrics

| Metric | Value |
|--------|-------|
| **Total Duration** | {{total-duration-minutes}} minutes |
| **Average Round Duration** | {{avg-round-duration}} seconds |
| **Total Word Count** | {{total-word-count}} words |
| **Memory Operations** | {{total-memory-ops}} ({{reads}} reads, {{writes}} writes) |
| **Agents Spawned** | {{total-agents}} |
| **States Completed** | {{completed-states}} / {{total-states}} |

---

## Next Steps

- **Next Workflow:** {{next-workflow}}
- **Handoff Artifacts:**
{{#each handoff-artifacts}}
  - {{artifact-name}} → `{{artifact-path}}`
{{/each}}
- **Ready For:** {{next-phase}}
- **Prerequisites Met:** {{prerequisites-status}}

---

## Session State at Completion

```json
{{session-state-json}}
```

---

## Memory Snapshot

### Namespaces Used

{{#each memory-namespaces}}
- **{{namespace-name}}:** {{key-count}} keys
  {{#each keys}}
  - `{{key-name}}` ({{value-size}} bytes)
  {{/each}}
{{/each}}

---

## Appendix

### Agent Configurations

{{#each agents}}
#### {{agent-name}}

- **Role:** {{role}}
- **Persona File:** `{{persona-file}}`
- **Tools:** {{tools}}
- **Config:**
  ```yaml
  {{config-yaml}}
  ```
{{/each}}

### Workflow Definition

**File:** `{{workflow-file-path}}`

**Key States:**
{{#each states}}
- {{state-name}} ({{agent}})
{{/each}}

---

**Generated:** {{generation-timestamp}}
**Generator:** Thursian Workflow System v{{version}}
**Template:** conversation-export.md v2.0.0
