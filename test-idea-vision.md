# TaskGraph: Product Vision Document

## 1. Core Concept

TaskGraph is an AI-powered task management application designed specifically for developers. Unlike traditional todo lists, TaskGraph represents work as an interactive dependency graph that visualizes relationships between tasks, highlights critical paths, and provides intelligent insights about what to work on next.

The application recognizes that developer work is inherently non-linear and interconnected. Tasks aren't isolated checkboxes - they block each other, touch the same files, and form complex dependency chains. TaskGraph makes these relationships visible and actionable.

## 2. Ah-Ha Insight

**"Static todo lists are fundamentally broken for developers because our work isn't static."**

Traditional task managers focus on "what's due next," but developers need to know "what happens next." The breakthrough insight is that developers already think in dependency graphs - we draw them on whiteboards during planning sessions. TaskGraph brings this natural mental model into a digital tool.

A secondary insight emerged during ideation: by building an API-first architecture, the product can enable use cases beyond what the core team builds, including AI agent integration, team collaboration, and automation workflows.

## 3. Key Features

### Core Features (v1)

**Graph Visualization**
- Force-directed graph layout using React Flow or D3.js
- Color-coded task nodes: green (completed), yellow (in progress), gray (blocked), white (ready)
- Dependency arrows showing which tasks block others
- Simple, clean visual design that developers want to open

**Daily Briefing**
- Automated daily analysis that identifies:
  - Critical Path: Task sequences that unblock the most work
  - Quick Wins: Tasks estimated under 30 minutes based on historical data
  - Danger Zones: Approaching deadlines with incomplete dependencies

**Natural Language Task Input**
- Parse task descriptions with AI to auto-extract tags, file references, and metadata
- Example: "Fix auth bug in user service" → auto-tagged as backend, bug, auth

**GitHub Integration**
- Import tasks from GitHub issues
- Auto-extract: title, labels, linked issues, mentioned files
- One-click import via GitHub API

**Completion Velocity Tracking**
- Track time between task creation and completion
- Group statistics by task type/tags
- Provide estimates: "You average 2 hours on bug fixes"

**Mission Control View**
- Zoom-to-fit on critical path
- Toggle to hide completed tasks
- Perfect for standup presentations

**API-First Architecture**
- Full REST API for all operations (create, update, delete tasks)
- WebSocket support for real-time updates
- Comprehensive API documentation (Swagger/OpenAPI)

### Polish Elements

**Visual Delight**
- Tailwind CSS for modern, clean UI
- Framer Motion for subtle animations when tasks cascade to "ready" state
- Completion celebrations that show ripple effects

**Smart Input**
- Autocomplete suggestions for tags and dependencies
- Natural language parsing via Claude API

## 4. MVP Scope

### 4-Week Build Timeline

**Week 1: Core Backend**
- PostgreSQL database schema (tasks, dependencies, tags)
- REST API with full CRUD operations
- GitHub OAuth for issue import
- JWT-based authentication

**Week 2: Graph Engine**
- Dependency resolution algorithms
- Critical path calculation
- Daily briefing generator (cron job)
- WebSocket server for real-time updates

**Week 3: Web Client**
- React Flow graph visualization
- Task creation/editing interface
- GitHub issue import button
- Daily briefing display

**Week 4: Polish + Documentation**
- Completion animations
- API documentation
- Example integrations (CLI script, Discord bot snippet, Claude Code script)
- Production deployment

### What v1 Includes
- Web application with graph UI
- Full REST API with documentation
- GitHub issue import
- Daily briefing analysis
- Completion velocity tracking
- Mission control view
- WebSocket support for multi-tab real-time updates
- One example integration: command-line task creation script

### What v1 Does NOT Include
- Built-in team collaboration features (API supports it)
- Native Discord bot (example code provided)
- AI agent integration UI (example curl commands provided)
- Advanced animations (pulsing, glowing nodes)
- Auto-clustering by file analysis
- Voice input
- Real-time IDE integration

## 5. Technical Direction

### Architecture
- **Backend**: Node.js/Express or similar
- **Database**: PostgreSQL
- **Frontend**: React with React Flow or D3.js
- **Styling**: Tailwind CSS
- **Animation**: Framer Motion
- **Real-time**: WebSocket server
- **AI Integration**: Claude API for NLP parsing
- **Authentication**: JWT tokens
- **GitHub Integration**: GitHub REST API with OAuth

### API Design Philosophy

Build a comprehensive, well-documented API that enables third-party integrations and future features without requiring changes to the core product.

**Core Endpoints:**
```
POST   /tasks              # Create task
PATCH  /tasks/:id          # Update status, add dependencies
GET    /tasks              # Get graph data
DELETE /tasks/:id          # Delete task
POST   /tasks/:id/link     # Connect to GitHub issue
GET    /briefing           # Get daily briefing
GET    /shared/:uuid       # Get read-only graph view
```

**WebSocket Events:**
- Task created
- Task updated
- Task completed
- Dependency added/removed

### Key Algorithms

**Critical Path Calculation**
- Identify longest dependency chain
- Highlight tasks that unblock the most work

**Daily Briefing Generation**
- Runs as scheduled job (cron)
- Analyzes entire task graph
- Generates actionable insights

**Time Estimation**
- Track actual completion times
- Group by task tags/types
- Provide rolling averages

## 6. Future Possibilities

### Post-v1 Enhancements (Informed by Dogfooding)

**Team Collaboration**
- Real-time multiplayer mode
- User avatars on task nodes
- Conflict detection for file overlaps
- Team-wide critical path visualization
- Collaboration insights in daily briefing

**Bidirectional GitHub Integration**
- Auto-close GitHub issues when tasks complete
- Sync GitHub issue comments to task nodes
- Auto-complete tasks when PRs merge
- Update dependencies when code changes

**Git Branch Awareness**
- Detect context-switching across branches
- Suggest optimal branch strategies
- Alert when tasks span too many branches
- Integration with merge/deploy workflows

**AI Agent Integration**
- Allow AI agents to create/update tasks programmatically
- Live graph updates as agents work
- Micro-task generation during execution
- Integration with Claude Code, n8n, Discord bots

**Advanced Pattern Detection**
- Day/time productivity patterns
- Task avoidance detection
- Momentum-based recommendations
- Auto-expansion of complex tasks into subtasks

**Orchestration System Integration**
- Discord commands create tasks
- n8n workflow triggers update task status
- Health monitors auto-create high-priority tasks
- Webhook-based automation

## 7. User Impact

### For Solo Developers

**Problem Solved**: Traditional task lists don't show how work interconnects, leading to poor prioritization and context-switching.

**Value Delivered**:
- Visual understanding of task dependencies
- Daily guidance on optimal work sequences
- Time estimates based on actual performance
- Reduced cognitive load in task planning

### For Development Teams

**Problem Solved**: Team members lack visibility into dependencies and blockers across the team.

**Value Delivered** (via API integrations):
- Shared understanding of critical paths
- Visibility into who's blocking whom
- Coordination opportunities identified automatically
- Real-time updates when dependencies resolve

### For AI-Assisted Development

**Problem Solved**: No existing task manager is designed for AI agents to update as they work.

**Value Delivered**:
- AI agents can create/update tasks programmatically
- Live visualization of agent progress
- Integration with automation workflows
- Bridge between human planning and AI execution

## 8. Next Steps

### Immediate Actions

1. **Validate Core Assumption**
   - Build minimal graph prototype (1-2 days)
   - Test with 5-10 developers
   - Confirm graph visualization resonates

2. **Technical Spike**
   - Prototype critical path algorithm
   - Test WebSocket performance at scale
   - Evaluate React Flow vs D3.js

3. **API Design**
   - Draft complete API specification
   - Review with potential integration partners
   - Finalize endpoint design before building

### Launch Strategy

**Week 1-4: Build MVP**
- Follow 4-week timeline outlined above
- Weekly progress reviews
- Iterative refinement based on dogfooding

**Week 5-8: Dogfooding**
- Use TaskGraph to build TaskGraph v2
- Implement example integrations (Discord bot, n8n workflow, Claude Code script)
- Document integration patterns
- Gather qualitative feedback

**Week 9+: Public Launch**
- Deploy to production
- Release API documentation
- Share example integrations
- Engage developer community
- Monitor which API endpoints get most usage (informs v2 priorities)

### Success Metrics

**Engagement**
- Daily active usage
- Tasks created per user per week
- Graph views per session

**API Adoption**
- Number of third-party integrations built
- API calls per day
- WebSocket connection duration

**Value Indicators**
- Task completion rate improvement
- Time spent in "blocked" state reduction
- User-reported prioritization confidence

### Decision Points

**After Dogfooding (Week 8)**
- If API usage is high → invest in better documentation and SDK
- If collaboration features are most-requested → prioritize team features for v2
- If AI agent integration gets traction → build native AI agent UI
- If adoption is low → reassess core value proposition

**After Public Launch (3 months)**
- Analyze which integrations community builds most
- Review feature requests and usage patterns
- Decide v2 feature set based on actual demand, not assumptions
