# Engineering Meeting Flow Guide

## Overview

The **Engineering Meeting Flow** is phase 3 of the Thursian ideation system. After users validate the idea through focus groups (phase 2), the Doer "brings the idea to engineering friends" for a technical design round table. The output is a comprehensive, industry-standard Product Requirements Document (PRD) that defines the WHAT, not yet the HOW.

## Architecture

```
Ideation Flow (Phase 1: Dreamer + Doer)
    ↓
Vision Document
    ↓
Focus Group Flow (Phase 2: User Validation)
    ↓
Focus Group Report
    ↓
Engineering Meeting Flow (Phase 3: Technical Validation) ← YOU ARE HERE
    ↓
Product Requirements Document (PRD)
    ↓
Technical Design Flow (Phase 4: The HOW)
```

## What Makes This Different

### 🎯 Engineering Round Table
Instead of solo technical analysis:
1. **5 diverse perspectives**: Domain expert, Product Manager, Marketing, UX, Tech Lead
2. **Collaborative discussion**: Round table format, not sequential reviews
3. **WHAT, not HOW**: Requirements and success criteria, not implementation details

### 🔍 Parallel Technical Research
While the team discusses:
- **Existing solutions**: What's already out there?
- **Open source libraries**: What can we leverage vs build?
- **Market saturation**: Is this space crowded or open?
- **Technical gaps**: Where are the real opportunities?

### ✅ Research-Backed Decisions
After each discussion round, technical research validates:
- **Validated Decisions**: Proven approaches backed by evidence
- **Risky Assumptions**: Ideas lacking precedent or support
- **Better Alternatives**: Overlooked solutions or libraries
- **Market Reality**: Saturation levels and differentiation opportunities

## The 5 Rounds

### Round 1: Technical Feasibility
**Tech Lead asks**: "What's feasible? What are the big architectural challenges?"

**Participants discuss**:
- Domain expert: Technical patterns and best practices
- Product Manager: MVP scope and phasing
- Marketing: Time-to-market and competitive timing
- UX Lead: Core interaction paradigms

**Research parallel**:
- Existing solutions in the space
- Open source libraries and frameworks
- Market saturation assessment
- Technical stack recommendations

**Output**: High-level architecture direction + feasibility assessment

---

### Round 2: Market Landscape
**Tech Lead asks**: "What already exists? Where are the gaps? What can we leverage?"

**Participants discuss**:
- Domain expert: Existing solutions and industry standards
- Product Manager: Competitive positioning and build vs buy
- Marketing: Market saturation and differentiation strategy
- UX Lead: Competitive UX patterns

**Research parallel**:
- Deep library analysis for each component
- Competitive feature matrices
- Saturation deep dive (funding, competitors, growth)
- Gap analysis (what exists vs what users want)

**Output**: Competitive positioning + technology leverage opportunities

---

### Round 3: Core Requirements (The WHAT)
**Tech Lead asks**: "What are we building? How do we prioritize?"

**Participants discuss**:
- Domain expert: Technical requirements and constraints
- Product Manager: Functional requirements, user stories, MVP definition
- Marketing: Market requirements and differentiation features
- UX Lead: UX requirements and accessibility

**Research parallel**:
- Feature benchmarking and feasibility validation
- Technical risk identification
- Requirement validation against real implementations

**Output**: Comprehensive requirements list (functional, non-functional, UX)

---

### Round 4: Dependencies and Risks
**Tech Lead asks**: "What could block us? What do we need?"

**Participants discuss**:
- Domain expert: Technical dependencies and third-party services
- Product Manager: Product risks and resource dependencies
- Marketing: Market risks and competitive timing
- UX Lead: Design dependencies and usability risks

**Research parallel**:
- Dependency validation (maintenance status, reliability)
- Risk assessment (likelihood, impact, mitigation)
- Alternative identification for risky dependencies

**Output**: Dependency map + risk register with mitigations

---

### Round 5: Success Criteria
**Tech Lead asks**: "How do we measure success? What's 'done'?"

**Participants discuss**:
- Domain expert: Technical metrics and quality criteria
- Product Manager: KPIs, launch criteria, product-market fit metrics
- Marketing: Acquisition targets, revenue goals
- UX Lead: Usability metrics and satisfaction benchmarks

**Research parallel**:
- Industry benchmark research
- Successful product case studies
- KPI standards and realistic targets

**Output**: Success metrics + launch criteria + roadmap phases

---

## Engineering Personas by Domain

The system automatically selects domain-appropriate experts:

### Gaming
**Domain Expert**: Game Designer/Engineer
- Expertise: Game mechanics, player psychology, monetization, game engines
- Concerns: Engagement metrics, churn, performance, platform compliance

### Productivity
**Domain Expert**: Productivity Systems Architect
- Expertise: Workflow optimization, collaboration, data sync, offline-first
- Concerns: Adoption, data security, performance, cross-platform

### Automation
**Domain Expert**: Automation Platform Architect
- Expertise: Workflow engines, RPA, integration patterns, orchestration
- Concerns: Reliability, error handling, monitoring, scalability

### Developer Tools
**Domain Expert**: Developer Tools Engineer
- Expertise: Developer experience, build systems, debugging, performance
- Concerns: DX, performance, ecosystem fit, adoption

### Mobile Apps
**Domain Expert**: Mobile Platform Architect
- Expertise: iOS/Android, React Native/Flutter, offline sync, performance
- Concerns: App size, battery life, platform guidelines, review process

### Web Apps
**Domain Expert**: Web Platform Architect
- Expertise: SPA, PWA, SSR, performance, accessibility, SEO
- Concerns: Browser compatibility, performance, SEO, security

*Custom domains can be added by extending the `engineering_personas` section in the YAML.*

## PRD Structure

The output PRD follows industry standards:

```markdown
# Product Requirements Document

## 1. Document Info
- Product name, version, date
- Authors and stakeholders
- Status and revision history

## 2. Executive Summary
- Product vision (1-2 paragraphs)
- Business opportunity (market size, TAM/SAM/SOM)
- Success criteria (what "winning" looks like)

## 3. Problem Statement
- User problems (from focus group)
- Current solutions and why they fail
- Our solution (high-level)

## 4. User Personas
- From focus group (who we're building for)
- User needs and pain points
- Use cases

## 5. Product Requirements
### Functional Requirements
- Must-Have (MVP): User stories with acceptance criteria
- Should-Have (Post-MVP): Version 1.1/1.2 features
- Could-Have (Future): Nice-to-haves
- Won't-Have (Out of Scope): Explicitly excluded

### Non-Functional Requirements
- Performance (speed, response time, throughput)
- Security (encryption, compliance, privacy)
- Scalability (concurrent users, data volume)
- Accessibility (WCAG, screen readers, keyboard nav)
- Platform requirements (OS versions, browsers)

### Technical Constraints
- Platform limitations
- Third-party dependencies
- Regulatory requirements

## 6. Success Metrics
- KPIs (acquisition, activation, retention, revenue, referral)
- Launch criteria (when MVP is "done")
- Performance targets
- Product-market fit indicators

## 7. Competitive Analysis
- Existing solutions (features, pricing, users)
- Our differentiation
- Market positioning
- Competitive advantages

## 8. Technical Considerations
- High-level architecture (NOT detailed design)
- Key technologies and why
- Third-party services and APIs
- Open source opportunities (libraries to leverage)
- Technical risks

## 9. Risks and Mitigations
- Technical risks (feasibility, scalability, dependencies)
- Market risks (competition, timing, saturation)
- Product risks (complexity, adoption)
- Mitigation strategies for each

## 10. Out of Scope
- Features explicitly NOT in MVP
- Future considerations (parking lot)
- Why these are out of scope

## 11. Timeline and Phases
- MVP scope and timeline
- Post-MVP roadmap (phases 2, 3, etc.)
- Key milestones

## 12. Appendix
- Research sources (technical + market)
- Focus group insights summary
- Competitive feature matrix
- Glossary of terms
```

## Usage

### Prerequisites
1. Completed focus group with report at:
   ```
   .thursian/ideation/focus-groups/{idea-id}-focus-group.md
   ```

2. AgentDB memory backend configured

3. Web search capabilities for technical research

### Running the Flow

```bash
# Option 1: Automatic handoff from focus group flow
# The focus group flow automatically triggers engineering meeting when complete

# Option 2: Manual execution
thursian-flow run engineering-meeting --input .thursian/ideation/focus-groups/my-idea-focus-group.md

# Option 3: With specific domain override
thursian-flow run engineering-meeting --input my-idea-focus-group.md --domain gaming
```

### Output

The flow creates a comprehensive PRD at:
```
.thursian/ideation/prds/{idea-id}-prd.md
```

Plus a technical research summary at:
```
.thursian/ideation/prds/{idea-id}-technical-research.md
```

## Memory Organization

### Namespaces
- `focus-group-synthesis`: Input from focus groups
- `engineering-personas`: Generated engineering personas
- `engineering-discussions`: Round-by-round discussion content
- `technical-research`: Research findings and alignments
- `product-requirements`: Final PRDs

### Cross-Phase Memory
The engineering meeting can access:
- `ideation-visions`: Original Dreamer-Doer vision
- `focus-group-discussions`: User feedback from focus groups
- `focus-group-research`: Market research from user validation

## Best Practices

### 1. Focus on WHAT, Not HOW
The PRD defines requirements, not implementation:
- ✅ "User can search rules in <5 seconds"
- ❌ "Use Elasticsearch with custom ranking algorithm"

The HOW comes in the next phase (Technical Design).

### 2. Leverage Existing Solutions
The technical researcher's job is to find what already exists:
- Don't reinvent wheels (use proven libraries)
- Identify saturated markets (avoid if possible)
- Find gaps (where you can differentiate)
- Recommend integration over building

### 3. Requirements Should Be Testable
Every requirement needs clear acceptance criteria:
- ✅ "Response time <5 seconds for 95th percentile"
- ❌ "Should be fast"

### 4. Prioritize Ruthlessly
MVP should be the absolute minimum:
- Must-Have: Can't ship without it
- Should-Have: Important but not critical
- Could-Have: Nice to have
- Won't-Have: Explicitly out of scope

### 5. Ground in Research
Every decision should have evidence:
- User research (focus groups)
- Competitive research (what exists)
- Technical research (what's feasible)
- Market research (what will sell)

## Key Differences from Focus Group

| Focus Group | Engineering Meeting |
|-------------|---------------------|
| **Who**: End users | **Who**: Technical experts |
| **Goal**: Validate user wants | **Goal**: Define buildable product |
| **Output**: User insights | **Output**: PRD |
| **Focus**: Will users use it? | **Focus**: Can we build it? |
| **Research**: User feedback, reviews | **Research**: Libraries, tech stacks, competitors |
| **Perspective**: User needs | **Perspective**: Technical feasibility + market viability |

## Integration with Next Phase

The PRD feeds into the Technical Design Flow (phase 4), where:
- Architects design detailed system architecture
- Engineers specify implementation approach
- The HOW is fully defined
- Technical specifications are created

The cycle:
```
User wants (focus group)
    +
What to build (engineering meeting PRD)
    +
How to build it (technical design)
    =
Ready for implementation
```

## Troubleshooting

### "Domain expert seems generic"
**Solution**: Add domain-specific expertise to persona template in YAML:
```yaml
gaming:
  domain_expert:
    expertise: [game_mechanics, player_psychology, specific_tech]
```

### "Research not finding relevant libraries"
**Solution**: Improve query specificity in technical researcher:
```yaml
- "{specific_component} javascript libraries 2024"
- "{exact_use_case} npm packages comparison"
```

### "PRD too vague or too detailed"
**Solution**: Remind agents of WHAT not HOW:
- ✅ "Search must return results in <5 seconds"
- ❌ "Implement caching layer with Redis for query optimization"

### "Market saturation analysis unclear"
**Solution**: Use concrete metrics in research:
- Competitor count (1-5: opportunity, 6-10: competitive, 10+: saturated)
- Funding levels ($0-10M: early, $10-100M: growing, $100M+: mature)
- Market growth (<5%: mature, 5-15%: growing, >15%: emerging)

## Performance Considerations

### Parallel Execution
Research runs parallel to all 5 discussion rounds:
- Average runtime: ~15-20 minutes for full flow
- Research continues throughout all discussions
- Alignment happens between rounds (~2-3 min each)

### Memory Usage
- Each persona: ~75-125 KB
- Each round discussion: ~30-75 KB
- Research data: ~500KB-1MB
- PRD output: ~50-150 KB
- Total per run: ~2-3 MB

### API Costs
- Web searches: ~25-40 searches per run
- Scraping operations: ~30-60 pages (GitHub, npm, docs)
- LLM calls: ~40-70 calls (persona responses, synthesis, PRD writing)

## Example Timeline

```
Minute 0-2: Initialize, detect domain, generate personas, start research
Minute 2-5: Round 1 discussion (technical feasibility)
Minute 5-7: Research alignment 1
Minute 7-10: Round 2 discussion (market landscape)
Minute 10-12: Research alignment 2 (deep library research)
Minute 12-15: Round 3 discussion (requirements)
Minute 15-17: Research alignment 3
Minute 17-20: Round 4 discussion (dependencies and risks)
Minute 20-22: Research alignment 4 (risk validation)
Minute 22-25: Round 5 discussion (success criteria)
Minute 25-27: Research alignment 5 (benchmarking)
Minute 27-35: PRD synthesis (comprehensive document)
Minute 35: Complete, handoff to technical design
```

## What Success Looks Like

A successful engineering meeting produces a PRD that:
- ✅ Clearly defines the problem and solution
- ✅ Lists testable, prioritized requirements
- ✅ Identifies what to build vs buy/integrate
- ✅ Acknowledges competitive landscape honestly
- ✅ Assesses technical risks with mitigations
- ✅ Sets measurable success criteria
- ✅ Scopes MVP realistically
- ✅ Is backed by research, not assumptions
- ✅ Can hand off to technical design for HOW

## Common Anti-Patterns to Avoid

### 🚫 Solution-First Thinking
**Wrong**: "We'll use React Native, PostgreSQL, and AWS Lambda..."
**Right**: "Cross-platform mobile app, relational data, serverless backend"
*(Save specific tech choices for technical design)*

### 🚫 Feature Creep
**Wrong**: MVP with 30 features
**Right**: MVP with 5-7 must-have features

### 🚫 Ignoring Research
**Wrong**: "Let's build our own search engine..."
**Right**: "Research shows Elasticsearch is mature and handles our scale..."

### 🚫 Vague Requirements
**Wrong**: "App should be fast"
**Right**: "95th percentile query response time <5 seconds"

### 🚫 Underestimating Competition
**Wrong**: "No one does this well, easy market"
**Right**: "10 competitors, but all slow (>10 sec). Our differentiation: <5 sec"

## Next Steps

After PRD approval:

1. **Review and Refine**: Stakeholders review PRD, suggest changes
2. **Validate Assumptions**: If any assumptions are unsupported, research more
3. **Prioritize Ruthlessly**: Ensure MVP is truly minimal
4. **Proceed to Technical Design**: Hand off to phase 4 for HOW

## Support

- Template: `.thursian/ideation/docs/prd-template.md`
- Examples: `.thursian/ideation/docs/example-prd.md`
- Questions: See `.thursian/ideation/docs/faq.md`

---

**Remember**: The engineering meeting defines the WHAT with technical validation. It's grounded in user needs (focus group) and market reality (research). The output is a clear, testable, prioritized set of requirements ready for the HOW (technical design).
