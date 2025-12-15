# Stakeholder Review Flow Guide

## Overview

The **Stakeholder Review Flow** is phase 3.5 (optional but recommended) of the Thursian ideation system. After the engineering team creates a PRD (phase 3), the Engineering Manager brings the PRD back to the original stakeholders—the Dreamer and Doer who started it all, and the focus group who validated user needs—for a final review before build begins.

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
Engineering Meeting Flow (Phase 3: PRD Creation)
    ↓
Product Requirements Document (PRD)
    ↓
Stakeholder Review Flow (Phase 3.5: Validation) ← YOU ARE HERE
    ↓
Approved PRD or Revision Plan
    ↓
Technical Design Flow (Phase 4: The HOW)
```

## Why This Matters

### The Problem This Solves

**Without stakeholder review**:
- PRD might drift from original vision
- User needs might be misinterpreted or diluted
- Build starts on wrong foundation
- Expensive fixes during development

**With stakeholder review**:
- Vision alignment validated before code is written
- User needs confirmed as accurately captured
- Stakeholder buy-in achieved
- Costly rework avoided

### Who Validates What

| Stakeholder | Validates | Key Question |
|-------------|-----------|--------------|
| **Dreamer** | Vision preserved | "Is this still the exciting idea I imagined?" |
| **Doer** | Feasibility maintained | "Can we actually build this?" |
| **User Personas (5)** | Needs met | "Does this solve my problems?" |
| **Engineering Manager** | Quality and clarity | "Is this PRD clear and buildable?" |

## The Review Process

### Opening: Excitement Round

Before diving into the PRD, everyone shares what excites them:

**Engineering Manager**: "Before we review the details, I'd love to hear: What excites you most about this idea?"

- **Dreamer**: Shares the original vision and innovation
- **Doer**: Shares confidence that it's now grounded and doable
- **Focus Group Personas**: Share problems being solved and features that matter

**Purpose**: Reconnect with the "why" before critiquing the "what"

---

### Section-by-Section Review (7 Sections)

The PRD is divided into 7 major section groups:
1. **Vision & Problem Statement**
2. **Users & Functional Requirements**
3. **Technical & Non-Functional Requirements**
4. **Success Metrics & KPIs**
5. **Competitive Analysis & Positioning**
6. **Risks & Out of Scope**
7. **Timeline & Roadmap**

For EACH section, the group goes through 5 rounds:

#### Round 1: Initial Reactions
**Question**: "What are your initial reactions to this section?"

**Stakeholders share**:
- First impressions
- Alignment with expectations
- Immediate concerns
- What stands out

**Example**:
- Dreamer: "I love how the executive summary captures the 'why'—instant answers without breaking game flow."
- User Persona: "The problem statement nails my frustration with slow rule lookups."

---

#### Round 2: Anything Missing?
**Question**: "Is there anything you thought would be in this section that's missing?"

**Stakeholders identify**:
- Gaps in coverage
- Forgotten elements
- Underrepresented aspects
- Missing perspectives

**Example**:
- Dreamer: "I expected more emphasis on the social aspect—not just fast answers, but keeping players together."
- User Persona: "My concern about battery drain isn't mentioned in non-functional requirements."

---

#### Round 3: Anything to Change?
**Question**: "Is there anything in this section you would like to see changed?"

**Stakeholders suggest**:
- Wording improvements
- Reframing or re-emphasis
- Corrections
- Reprioritization

**Example**:
- Doer: "The timeline feels aggressive. Can we add 2 weeks for beta testing?"
- User Persona: "The primary persona description doesn't quite match me. Can we adjust the age range?"

---

#### Synthesis (Engineering Manager)
**Between Rounds 3 and 4**, the Engineering Manager synthesizes all feedback:

"Here's what I've heard for this section:
- 3 items about vision alignment
- 2 items about missing features
- 4 suggestions for wording changes
- 1 concern about timeline

Now let's prioritize: which are critical vs nice-to-have?"

---

#### Round 4: Critical Issues
**Question**: "Of all the feedback, which issues are CRITICAL to address before we move forward?"

**Stakeholders prioritize**:
- Must-fix before approval
- Blocks progress if not addressed
- Core to vision/user needs/feasibility

**Example**:
- Dreamer: "The missing social aspect is CRITICAL. Our differentiation isn't just speed, it's preserving game night."
- User Persona: "Battery drain IS critical—if my phone dies mid-game, I won't use the app."

---

#### Round 5: Nice-to-Haves
**Question**: "Of the remaining feedback, which issues are NICE-TO-HAVE?"

**Stakeholders identify**:
- Would improve but not essential
- Polish and refinement
- Future considerations

**Example**:
- Doer: "The extra 2 weeks for beta testing is nice-to-have, but we can iterate post-launch."
- User Persona: "Adjusting my age range is minor, not worth blocking on."

---

### Final Synthesis

After all 7 sections are reviewed, the Engineering Manager creates a **Comprehensive Feedback Report**:

**Executive Summary**:
- Overall sentiment (excited? concerned? mixed?)
- Approval status recommendation
- Key themes across all sections

**Critical Issues** (by section):
- What MUST be changed
- Why it's critical
- Who raised it
- Recommended fix

**Nice-to-Haves** (by section):
- What SHOULD be changed
- Level of importance
- Feasibility of incorporating

**Stakeholder Quotes**:
- Key moments from the discussion
- Vision statements
- User validations
- Concerns raised

**Annotated PRD**:
- Original PRD with inline comments
- Color-coded feedback (critical = red, nice-to-have = yellow)
- Suggested changes tracked

**Next Steps**:
- Approval decision (approve / approve with changes / revise)
- If revision needed: what to address
- If approved: proceed to technical design

---

### Decision Point

The Engineering Manager presents the synthesis and asks:

**"Given this feedback, I see three paths:**
1. **Approve as-is**: PRD is good enough, let's build
2. **Approve with critical changes**: Incorporate critical feedback and proceed
3. **Revise and review again**: Too many concerns, need another round

**What do you think?"**

The group discusses and reaches consensus.

---

## Typical Timeline

```
Minute 0-10: Opening introductions and excitement sharing
Minute 10-20: Section 1 (Vision & Problem) - 5 rounds
Minute 20-30: Section 2 (Users & Requirements) - 5 rounds
Minute 30-40: Section 3 (Technical & NFR) - 5 rounds
Minute 40-50: Section 4 (Success Metrics) - 5 rounds
Minute 50-60: Section 5 (Competitive Analysis) - 5 rounds
Minute 60-70: Section 6 (Risks & Scope) - 5 rounds
Minute 70-80: Section 7 (Timeline & Roadmap) - 5 rounds
Minute 80-90: Final synthesis and decision
Total: ~90 minutes for full stakeholder review
```

*Can be compressed to 60 minutes if stakeholders are highly aligned*

## Usage

### Prerequisites

1. Completed PRD from engineering meeting at:
   ```
   .thursian/ideation/prds/{idea-id}-prd.md
   ```

2. Memory of previous personas:
   - Dreamer and Doer from ideation phase
   - 5 focus group personas from validation phase

3. Engineering Manager facilitator

### Running the Flow

```bash
# Option 1: Automatic handoff from engineering meeting
# (engineering meeting can optionally trigger stakeholder review)

# Option 2: Manual execution
thursian-flow run stakeholder-review --input .thursian/ideation/prds/my-idea-prd.md

# Option 3: Skip if stakeholders already aligned
thursian-flow skip stakeholder-review --proceed-to technical-design
```

### Output

The flow creates two key documents:

**1. Stakeholder Feedback Report**:
```
.thursian/ideation/prds/{idea-id}-stakeholder-feedback.md
```

**2. Approved PRD** (if approved):
```
.thursian/ideation/prds/{idea-id}-prd-approved.md
```

Or **Revision Plan** (if revision needed):
```
.thursian/ideation/prds/{idea-id}-revision-plan.md
```

## Example Outcomes

### Scenario 1: Approved with Minor Changes

**Feedback**:
- 2 critical issues (both easy fixes: wording changes)
- 8 nice-to-have suggestions
- Overall sentiment: Enthusiastic

**Decision**: "Approve with critical changes"

**Next Steps**:
- Engineering Manager updates PRD with 2 critical fixes
- Proceed to technical design immediately
- Nice-to-haves tracked for PRD v2

---

### Scenario 2: Significant Misalignment

**Feedback**:
- 12 critical issues across multiple sections
- Vision drift: Dreamer says "This isn't what I envisioned"
- User needs: Multiple personas say "This doesn't solve my problem"

**Decision**: "Revise and review again"

**Next Steps**:
- Product Manager works with engineering team to revise PRD
- Address all critical issues
- Schedule follow-up stakeholder review in 1 week

---

### Scenario 3: Perfect Alignment

**Feedback**:
- 0 critical issues
- 5 nice-to-have suggestions (all polish)
- Universal excitement and buy-in

**Decision**: "Approve as-is"

**Next Steps**:
- Proceed directly to technical design
- Nice-to-haves tracked for future iterations
- Build begins immediately

---

## Best Practices

### 1. Create Psychological Safety
**Engineering Manager sets tone**:
- "We WANT critical feedback. Better to find issues now than during build."
- "No idea is off limits. Challenge anything that doesn't feel right."
- "This is OUR PRD, not the engineering team's PRD."

### 2. Balance Perspectives
Ensure each stakeholder type is heard:
- Visionary (Dreamer): Does this preserve innovation?
- Pragmatist (Doer): Is this buildable?
- Users (Focus Group): Does this solve problems?
- Domain Expert (Persona 5): Does this follow best practices?

### 3. Keep Focused
- Don't redesign the product in review (that's for next iteration)
- Don't debate implementation details (that's for technical design)
- Focus on: Does the PRD accurately capture WHAT we're building?

### 4. Prioritize Ruthlessly
Not everything can be critical:
- **Critical**: Blocks approval, must be fixed now
- **Nice-to-have**: Improves PRD but not blocking
- **Out of scope**: Interesting but for later phases

### 5. Document Everything
Capture feedback accurately:
- Who said what
- Why they said it
- What they recommend
- Consensus level

### 6. Drive Decisions
Don't leave review without clear outcome:
- ✅ Approved (with or without changes)
- ⚠️ Revise and review again
- Clear next steps and owners

## Common Anti-Patterns to Avoid

### 🚫 Rubber Stamping
**Wrong**: Everyone agrees too quickly without real engagement
**Right**: Probe for honest feedback, welcome criticism

### 🚫 Scope Creep
**Wrong**: "Let's also add this new feature we just thought of"
**Right**: "Great idea! Let's track for PRD v2 or future roadmap"

### 🚫 Implementation Debates
**Wrong**: "Should we use React Native or Flutter?"
**Right**: "Are the technical requirements clear? Good. Implementation details come next."

### 🚫 False Consensus
**Wrong**: Stakeholders agreeing to avoid conflict
**Right**: Engineering Manager probes: "I'm hearing agreement, but no excitement. What's the concern?"

### 🚫 Endless Revision
**Wrong**: "Let's review the PRD 5 times until it's perfect"
**Right**: "Two rounds max. After that, we iterate post-launch."

## Integration with Other Phases

### Input: From Engineering Meeting
The PRD arrives with:
- Technical validation (feasible)
- Competitive analysis (differentiated)
- Market research (viable)
- Requirements defined (clear WHAT)

### Validation: Stakeholder Review Adds
- Vision alignment (matches original intent)
- User validation (meets real needs)
- Stakeholder buy-in (ready to commit)
- Final polish (clear and compelling)

### Output: To Technical Design
Approved PRD proceeds with:
- Stakeholder confidence
- Vision-user-feasibility triangle validated
- Critical issues resolved
- Ready for HOW (detailed architecture)

## Troubleshooting

### "Stakeholders can't make the meeting"
**Solution**: Asynchronous review
- Share PRD with comment mode
- Set deadline for feedback
- Synthesize and make decision via voting

### "Too much conflicting feedback"
**Solution**: Prioritization framework
- Categorize by stakeholder concern
- Identify blocking vs non-blocking
- Engineering Manager makes tiebreaker call

### "Dreamer feels vision was lost"
**Solution**: Deep dive session
- 1-on-1 with Dreamer: What's missing?
- Understand specific concerns
- Find compromises that preserve magic while staying feasible

### "Users say needs aren't met"
**Solution**: Back to focus group insights
- Re-read focus group report
- Identify disconnect between feedback and PRD
- Revise requirements to match validated needs

## Key Success Indicators

A successful stakeholder review achieves:
- ✅ All 7 stakeholders engaged and contributing
- ✅ Honest, critical feedback provided
- ✅ Critical issues identified and prioritized
- ✅ Clear decision reached (approve or revise)
- ✅ Stakeholders confident in the PRD
- ✅ Vision-user-feasibility alignment validated
- ✅ Ready to proceed to build with confidence

## Next Steps After Review

### If Approved
1. **Engineering Manager**: Updates PRD with critical changes
2. **Product Manager**: Finalizes approved PRD
3. **Technical Lead**: Begins technical design (the HOW)
4. **Team**: Moves to implementation planning

### If Revision Needed
1. **Product Manager**: Creates revision plan
2. **Engineering Team**: Addresses critical issues
3. **Stakeholders**: Receive updated PRD for review
4. **Engineering Manager**: Schedules follow-up review (1-2 weeks)

### If Approved As-Is
1. **Team**: Celebrates alignment 🎉
2. **Technical Design**: Begins immediately
3. **Nice-to-Haves**: Tracked for PRD v2 or future iterations

## Support

- Template: `.thursian/ideation/docs/stakeholder-review-template.md`
- Examples: `.thursian/ideation/docs/example-stakeholder-feedback.md`
- Questions: See `.thursian/ideation/docs/faq.md`

---

**Remember**: The stakeholder review is the final checkpoint before build. It ensures the PRD captures the vision, meets user needs, and is technically sound. Invest the 90 minutes now to avoid weeks of rework later.
