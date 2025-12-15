# Focus Group Flow Guide

## Overview

The **Focus Group Flow** is phase 2 of the Thursian ideation system. After the Dreamer and Doer create an exciting, feasible vision (phase 1), the Doer "calls up friends" to get real user feedback through a simulated focus group grounded in actual web research.

## Architecture

```
Ideation Flow (Phase 1)
    ↓
Vision Document
    ↓
Focus Group Flow (Phase 2) ← YOU ARE HERE
    ↓
Focus Group Report + Research Synthesis
    ↓
Engineering Review Flow (Phase 3)
```

## What Makes This Different

### 🎭 Dynamic Persona Generation
Instead of fixed personas, the system:
1. Analyzes the vision document to detect domain (gaming, productivity, automation, etc.)
2. Generates 5 domain-specific personas with realistic demographics
3. Adapts persona backgrounds to match the specific idea

### 🌐 Parallel Web Research
While the focus group discusses:
- A research agent runs real web searches
- Scrapes actual user reviews, Reddit posts, forum discussions
- Analyzes demographics from real data sources
- After each round, aligns simulated feedback with real-world data

### ✅ Reality Validation
After each discussion round, the researcher creates an alignment report:
- **Confirmations**: Where simulation matches reality
- **Contradictions**: Where simulation diverges from real data
- **Gaps**: What real users mention that personas missed

## The 5 Rounds

### Round 1: Discussion of the Idea
**Facilitator asks**: "What's your initial reaction? What excites you or concerns you?"

**Research parallel**:
- User reviews for similar products
- Reddit discussions about pain points
- User demographics statistics
- Forum feedback

**Output**: First impressions and gut reactions + baseline market sentiment

---

### Round 2: Expanding Wider
**Facilitator asks**: "How does this fit into your broader {domain} life? What other tools would this interact with?"

**Research parallel**:
- Ecosystem and integration patterns
- Competitive landscape analysis
- Alternative product comparisons
- Market positioning data

**Output**: Ecosystem fit insights + competitive intelligence

---

### Round 3: Diving Deeper
**Facilitator asks**: "Walk me through how you'd actually use this. What features are must-haves versus nice-to-haves?"

**Research parallel**:
- Most requested features from forums
- Feature usage statistics
- User adoption data
- Workflow analysis

**Output**: Detailed use cases + validated feature priorities

---

### Round 4: Pain Points
**Facilitator asks**: "What could frustrate you? What pain points from other {domain} tools should we absolutely avoid?"

**Research parallel**:
- Common user complaints
- Why users quit similar tools
- Negative reviews analysis
- Churn studies

**Output**: Critical concerns + real failure modes

---

### Round 5: Final Thoughts
**Facilitator asks**: "Bottom line: would you use this? What would make it a must-have versus nice-to-have?"

**Research parallel**:
- Market size and opportunity
- Successful product traits
- Adoption rate indicators
- Willingness to pay data

**Output**: Overall assessment + market validation

## Domain-Specific Personas

### Gaming Domain
1. **Board Gamer** (25-40, strategy-focused, social)
2. **Card Gamer** (18-35, competitive, deck-builder)
3. **Mobile Gamer** (20-45, casual-to-midcore)
4. **PC Gamer** (15-40, hardcore, performance-focused)
5. **Game Designer** (25-50, professional expert)

### Productivity Domain
1. **Individual Contributor** (25-40, efficiency-focused)
2. **Team Lead** (30-50, coordination-focused)
3. **Freelancer** (22-45, multi-client)
4. **Enterprise User** (30-55, compliance-aware)
5. **Productivity Consultant** (28-55, methodology expert)

### Automation Domain
1. **Power User** (25-45, tech-savvy scripter)
2. **Business Analyst** (28-50, process-focused, non-technical)
3. **Developer** (22-40, integration-focused)
4. **Operations Manager** (35-55, ROI-driven)
5. **Automation Architect** (30-50, enterprise-scale expert)

### Developer Tools Domain
1. **Junior Developer** (20-28, learning-focused)
2. **Senior Developer** (28-45, efficiency-focused)
3. **DevOps Engineer** (25-40, automation-minded)
4. **Tech Lead** (30-50, team-focused)
5. **Developer Advocate** (25-45, community-focused expert)

*Additional domains can be added by extending the `persona_templates` section in the YAML.*

## Usage

### Prerequisites
1. Completed ideation flow with vision document at:
   ```
   .thursian/ideation/visions/{idea-id}-vision.md
   ```

2. AgentDB memory backend configured

3. Web search capabilities enabled for research agent

### Running the Flow

```bash
# Option 1: Automatic handoff from ideation flow
# The ideation flow automatically triggers focus group when complete

# Option 2: Manual execution
thursian-flow run focus-group --input .thursian/ideation/visions/my-idea-vision.md

# Option 3: With specific domain override
thursian-flow run focus-group --input my-idea-vision.md --domain gaming
```

### Output

The flow creates a comprehensive report at:
```
.thursian/ideation/focus-groups/{idea-id}-focus-group.md
```

**Report Structure**:
1. **Executive Summary**: Top 5-7 insights
2. **Persona Profiles**: Who participated and their backgrounds
3. **Round-by-Round Insights**: Detailed discussion summaries
4. **Research Validation**: How simulation aligned with real data
5. **Key Findings**:
   - What users love
   - What users fear
   - Must-have features
   - Deal-breakers
   - Market validation
6. **Recommendations**:
   - High-priority changes
   - Feature priorities
   - Risk mitigation
   - Go-to-market insights
7. **Appendix**:
   - Full transcripts
   - Research sources
   - Demographic data

## Memory Organization

### Namespaces
- `ideation-visions`: Input vision documents
- `focus-group-personas`: Generated persona specifications
- `focus-group-discussions`: Round-by-round discussion content
- `focus-group-research`: Web research findings and alignments
- `focus-group-synthesis`: Final synthesized reports

### Cross-Phase Memory
The focus group flow can access:
- `ideation-conversations`: Original Dreamer-Doer dialogue
- `ideation-ideas`: Initial idea documents

## Extending the System

### Adding New Domains

Edit `focus-group-flow.yaml` and add to `persona_templates`:

```yaml
persona_templates:

  your_new_domain:
    personas:
      - type: persona_type_1
        demographics: [age_range, key_trait_1, key_trait_2]
        preferences: [pref_1, pref_2, pref_3]
        pain_points: [pain_1, pain_2, pain_3]

      - type: persona_type_2
        # ... 3 more user personas ...

      - type: domain_expert
        demographics: [age_range, professional_level]
        expertise: [expertise_area_1, expertise_area_2]
        perspectives: [perspective_1, perspective_2]
```

### Customizing Research Sources

Modify the `researcher` agent's `sources` configuration:

```yaml
agents:
  - id: researcher
    config:
      sources: [reddit, reviews, forums, your_custom_source]
```

Then update `.thursian/ideation/agents/researcher.md` with custom source handling.

### Adjusting Discussion Rounds

To add or modify rounds, edit the workflow states:

```yaml
workflow:
  states:
    round_X_discussion:
      description: "Round X: Your custom focus"
      # ... agent configurations
```

## Best Practices

### 1. Domain Detection Quality
The quality of persona generation depends on clear domain signals in the vision document. Ensure your vision includes:
- Clear problem domain mention
- Target user descriptions
- Use case examples

### 2. Research Query Optimization
Edit research queries in the workflow to be more specific:
```yaml
- type: web.search
  queries:
    - "{domain} {specific_aspect} user feedback reddit"
```

### 3. Persona Authenticity
Review generated personas before the discussion:
```bash
thursian-flow inspect personas --focus-group-id my-idea
```

Adjust if needed to ensure realistic diversity.

### 4. Research Source Credibility
The researcher agent prioritizes:
- Recent data (last 12 months)
- Diverse source types
- Large sample sizes

Flag in reports when data is thin or outdated.

### 5. Simulation-Reality Balance
The goal is not perfect simulation, but **reality-grounded speculation**:
- Personas can explore hypotheticals
- Research validates or challenges those hypotheticals
- Final recommendations blend both

## Integration with Next Phase

The focus group report feeds into the Engineering Review Flow (phase 3), where:
- Engineers assess technical feasibility
- Architects design system structure
- Security reviews surface risks
- Performance analysts estimate costs

The cycle:
```
User wants (focus group)
    +
Technical reality (engineering review)
    =
Informed implementation plan
```

## Troubleshooting

### "Domain not detected"
**Solution**: Add explicit domain tag to vision document:
```markdown
<!-- domain: gaming -->
# Vision Document
...
```

### "Personas feel generic"
**Solution**: Increase `background_depth` in agent config:
```yaml
config:
  background_depth: very_detailed
```

### "Research misaligned with target users"
**Solution**: Add demographic constraints to research queries:
```yaml
- "{domain} {demographic_filter} user feedback"
```

### "Discussion feels shallow"
**Solution**: Increase `depth` in facilitator moderation:
```yaml
- type: moderate_discussion
  ensure: [all_voices_heard, authentic_responses, depth]
  depth: comprehensive
```

## Performance Considerations

### Parallel Execution
Research runs in parallel with discussions:
- Average runtime: ~8-12 minutes for full flow
- Research continues during all 5 rounds
- Alignment happens between rounds (adds ~1-2 min per round)

### Memory Usage
- Each persona: ~50-100 KB
- Each round discussion: ~20-50 KB
- Research data: ~200-500 KB
- Total per run: ~1-2 MB

### API Costs
- Web searches: ~15-25 searches per run
- Scraping operations: ~20-40 pages
- LLM calls: ~30-50 calls (agent responses + synthesis)

## Example Output Preview

```markdown
# Focus Group Report: AI-Powered Board Game Helper

## Executive Summary

- ✅ Strong validation from board gamers and designers
- ⚠️ Concerns about replacing human interaction
- 🎯 Must-have: Rule clarification, NOT strategy hints
- 🔴 Deal-breaker: Requires internet, adds setup time
- 📊 Market: 15M board game households in US, 67% want digital helpers
- 💡 Unique angle: Focus on accessibility for new players

## Persona Profiles

### Sarah Chen - Board Game Enthusiast
- Age 32, plays 3-4 times/month, prefers medium-complexity euros
- Pain points: Teaching new players, rule lookups mid-game
- Tech comfort: High (uses BoardGameGeek, digital scorekeepers)

[... 4 more personas ...]

## Round 1: Initial Reactions

### Focus Group Discussion
Sarah: "I love the idea of instant rule lookups! We spend so much time..."
Mike: "My concern is it might take away the 'figuring it out' aspect..."
[...]

### Research Alignment ✅
- **Confirmed**: 73% of BGG users report rule lookups as top frustration
- **Confirmed**: 45% concerned about "over-assistance" in strategy games
- Sources: BGG survey 2024, r/boardgames poll (n=2,341)

[... rounds 2-5 ...]

## Recommendations

### High Priority
1. **Focus on rules, not strategy** (unanimous from focus group + backed by BGG data)
2. **Offline mode essential** (82% of users play in locations with poor WiFi)
3. **Sub-5-second response time** (churn risk if slower, per app store reviews)

[...]
```

## Next Steps

After reviewing the focus group report:

1. **Validate Surprises**: Any contradictions between simulation and research? Investigate further.
2. **Prioritize Features**: Use the must-haves list to scope MVP.
3. **Mitigate Risks**: Address deal-breakers in design.
4. **Prepare for Engineering**: The report hands off to technical feasibility review.

## Support

- Issues: File at `.thursian/ideation/issues/`
- Questions: See `.thursian/ideation/docs/faq.md`
- Extending: See `.thursian/ideation/docs/customization-guide.md`

---

**Remember**: The focus group is a tool for rapid, research-backed user validation. It's not a replacement for talking to real users, but it helps you ask smarter questions when you do.
