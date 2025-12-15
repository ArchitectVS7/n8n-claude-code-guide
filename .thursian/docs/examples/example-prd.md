# Product Requirements Document: RulesMate

**Version**: 1.0.0
**Date**: 2024-01-20
**Status**: Approved for Technical Design

**Authors**:
- Technical Lead: Alex Chen (Engineering)
- Product Manager: Jordan Smith
- Domain Expert: Dr. Reiner Keller (Game Design)
- Marketing Analyst: Maria Garcia
- UX Lead: Sam Patel

**Stakeholders**:
- Engineering: Development team
- Design: UI/UX team
- Marketing: GTM team
- Business: CEO, CFO

**Revision History**:
| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 0.1 | 2024-01-15 | Initial draft | Jordan Smith |
| 0.2 | 2024-01-17 | Technical validation | Alex Chen |
| 1.0 | 2024-01-20 | Approved final | All stakeholders |

---

## Executive Summary

### Product Vision
RulesMate is a mobile companion app that instantly answers board game rule questions in under 5 seconds, even offline. We solve the #1 frustration in board gaming (rule lookups that break game flow) by providing fast, accurate, visual answers that let players get back to the game.

### Business Opportunity

**Market Size**:
- **TAM**: $360M/year (15M US board game households × $24/year average spend)
- **SAM**: $144M/year (6M regular gamers playing 3+ times/month × $24/year)
- **SOM Year 1**: $240K (6,000 paying users × $40/year average)
- **SOM Year 3**: $2.4M (60,000 paying users × $40/year average)

**Market Validation**:
- Focus group: 8.2/10 enthusiasm across 5 personas
- 67% of BGG users willing to pay for "perfect rules tool" (BGG Survey 2024)
- Board game market growing 12% CAGR, digital tools 18% CAGR
- Clear gap: existing tools are slow (Dized 12-15 sec), require internet, or have limited coverage

**Success Criteria**:
- **Year 1**: 10K downloads, 15% conversion to paid, 40% monthly retention
- **Product-Market Fit**: 40%+ users "very disappointed" if product went away
- **Revenue**: $240K Year 1, path to $2.4M Year 3

---

## Problem Statement

### User Problems

**Primary Pain Point**: Rule lookups break game flow
- 73% of board gamers cite "rule lookups" as top frustration (BGG Survey 2024)
- Average lookup time: 3-8 minutes (Google, rulebook PDF search, forum posts)
- Flow disruption leads to: lost momentum, frustration, house rules that break games

**Secondary Pain Points**:
1. **Teaching new players** takes forever (parents, game cafes)
2. **Complex rule interactions** are hard to resolve mid-game
3. **Offline scenarios** common (cabins, basements, poor WiFi)

### Current Solutions (and Why They Fail)

| Solution | What It Does | Why It Fails |
|----------|--------------|--------------|
| **Dized** | Rule search, learn mode | • Slow (12-15 sec avg)<br>• Requires internet<br>• Limited games (500) |
| **YouTube (Watch It Played)** | Tutorial videos | • Not searchable mid-game<br>• 15-30 min videos<br>• Can't quick-reference |
| **BGG Forums/Files** | Community Q&A, rule PDFs | • Slow (forum search, PDF download)<br>• Quality varies<br>• Fragmented |
| **Rulebook PDFs** | Official rules | • Not searchable across games<br>• Poor mobile experience<br>• No quick lookup |

**Core Failure**: None are optimized for the mid-game use case (fast, offline, accurate answer).

### Our Solution

**RulesMate**: Mobile-first rule companion that answers questions in <5 seconds, works offline, and covers top 500 BGG games.

**Key Differentiators**:
1. **Speed**: 3x faster than Dized (<5 sec vs 12-15 sec)
2. **Offline**: Works anywhere (vs internet-dependent tools)
3. **Accuracy**: Official publisher partnerships (vs crowdsourced, unverified)
4. **Visual**: Rulebook screenshots (vs text-only answers)
5. **Simple**: 1-2 taps to answer (vs complex multi-step flows)

---

## User Personas (From Focus Group)

### Primary: Sarah Chen - Social Board Gamer
- **Demographics**: 32, plays 3-4x/month with friends, medium-complexity euros
- **Needs**: Quick rule answers that don't break social flow
- **Pain Points**: Teaching friends, mid-game disputes, slow lookups
- **Willingness to Pay**: $3-4/month or $30/year
- **Quote**: *"I love the social aspect, but looking up rules breaks the flow"*

### Secondary: Mike Rodriguez - Competitive Strategy Gamer
- **Demographics**: 28, plays 5-6x/month, heavy games and tournaments
- **Needs**: Complex edge-case rule handling, offline capability
- **Pain Points**: Rule interactions in complex games, slow tools
- **Willingness to Pay**: $5/month or $40/year
- **Quote**: *"If this just gives strategy hints, I'm out. I want rules, not advice"*

### Tertiary: Jamie Park - Casual Family Gamer
- **Demographics**: 38, plays 2-3x/month with kids (ages 7 & 10)
- **Needs**: Simple guided turns for kids, accessible interface
- **Pain Points**: Making games fun for kids, constant explaining
- **Willingness to Pay**: $2-3/month or $20 one-time
- **Quote**: *"My kids lose interest when we spend 10 minutes finding a rule"*

### Business: Alex Thompson - Game Cafe Owner
- **Demographics**: 45, runs 30-game-night events weekly, teaches 200+ games
- **Needs**: Multi-game session management, fast answers across tables
- **Pain Points**: Teaching multiple games simultaneously
- **Willingness to Pay**: $20/month for business tier
- **Quote**: *"I need to teach 5 tables different games. Anything that helps is gold"*

---

## Product Requirements

### Functional Requirements

#### Must-Have (MVP - Priority P0)

**FR-1: Instant Rule Search**
- **User Story**: As a player mid-game, I want to ask a rule question and get an answer in under 5 seconds so game flow isn't disrupted
- **Acceptance Criteria**:
  - [ ] Text search returns results in <5 sec (95th percentile)
  - [ ] Voice search returns results in <5 sec (95th percentile)
  - [ ] Results include text answer + rulebook visual reference
  - [ ] Works for all top 100 BGG games
- **Priority**: P0 (must-have)
- **Success Metric**: 95th percentile response time <5 sec, 90%+ accuracy

**FR-2: Offline Mode**
- **User Story**: As a player in a cabin/basement, I want the app to work without internet so I can play anywhere
- **Acceptance Criteria**:
  - [ ] Top 100 BGG games pre-downloaded
  - [ ] Full search and answer functionality offline
  - [ ] Clear offline/online status indicator
  - [ ] Background sync when online
- **Priority**: P0 (must-have)
- **Success Metric**: 100% core features work offline, <30 MB data per game

**FR-3: Visual Rulebook References**
- **User Story**: As a player uncertain about an answer, I want to see the actual rulebook page so I can verify the rule
- **Acceptance Criteria**:
  - [ ] Each answer shows screenshot from official rulebook
  - [ ] Page number and section reference included
  - [ ] Zooming and panning supported for readability
  - [ ] Works offline (images pre-cached)
- **Priority**: P0 (must-have)
- **Success Metric**: 100% of answers have visual reference

**FR-4: Voice Search**
- **User Story**: As a player mid-game, I want to ask questions hands-free so I don't have to put down game components
- **Acceptance Criteria**:
  - [ ] Voice button prominently placed
  - [ ] 90%+ transcription accuracy
  - [ ] Natural language understanding ("Can I trade before rolling?" works)
  - [ ] Fallback to text search if voice fails
- **Priority**: P0 (must-have)
- **Success Metric**: 70%+ of searches use voice, 90%+ accuracy

**FR-5: Game Selection**
- **User Story**: As a player, I want the app to know what game I'm playing so search results are relevant
- **Acceptance Criteria**:
  - [ ] Recently played games shown first
  - [ ] BGG integration to import user library (opt-in)
  - [ ] Manual game selection with autocomplete
  - [ ] QR code scan from game box (nice-to-have)
- **Priority**: P0 (must-have)
- **Success Metric**: <3 taps to select game for new users, <1 tap for returning users

#### Should-Have (Post-MVP - Priority P1)

**FR-6: Beginner Step-by-Step Mode**
- **User Story**: As a new player (or parent with kids), I want guided turn-by-turn instructions so I can learn the game
- **Acceptance Criteria**:
  - [ ] Visual step-by-step for each turn phase
  - [ ] Kid-friendly language option
  - [ ] Progress tracking (current phase highlighted)
  - [ ] Available for top 50 family games at launch
- **Priority**: P1 (should-have)
- **Success Metric**: 30%+ of family game users activate mode

**FR-7: Video Tutorial Integration**
- **User Story**: As a learner, I want links to specific video timestamps so I can see rule demonstrations
- **Acceptance Criteria**:
  - [ ] Links to Watch It Played and similar channels
  - [ ] Timestamp deep-links to specific rules
  - [ ] Available for top 100 games
- **Priority**: P1 (should-have)
- **Success Metric**: 15%+ clickthrough rate on video links

**FR-8: BGG / BG Stats Integration**
- **User Story**: As a user of BG Stats, I want my game library synced so I don't have to manually add games
- **Acceptance Criteria**:
  - [ ] OAuth integration with BGG and BG Stats
  - [ ] Import user's collection
  - [ ] Sync play history for game suggestions
- **Priority**: P1 (should-have)
- **Success Metric**: 40%+ of users connect accounts

#### Could-Have (Future - Priority P2)

**FR-9: Multi-Game Session Management** (Business Tier)
- **User Story**: As a game cafe owner, I want to manage multiple tables/games simultaneously
- **Acceptance Criteria**:
  - [ ] Multi-device support (5+ devices per account)
  - [ ] Dashboard showing active games/questions
  - [ ] Flag unanswered questions to human
- **Priority**: P2 (could-have)
- **Success Metric**: 50%+ of cafe accounts use feature

**FR-10: Setup Assistance**
- **User Story**: As a player, I want guided setup instructions so we don't make mistakes
- **Acceptance Criteria**:
  - [ ] Step-by-step setup checklist
  - [ ] Component identification (visual matching)
  - [ ] Player count configuration
- **Priority**: P2 (could-have)
- **Success Metric**: 20%+ of users access feature

#### Won't-Have (Explicitly Out of Scope)

**FR-X: Strategy Tips**
- **Rationale**: Focus group resistance (45% concerned about "playing game for them")
- **Future**: Maybe premium opt-in, clearly labeled as optional

**FR-Y: Scorekeeping**
- **Rationale**: BG Stats already does this well, don't compete
- **Future**: Integration over building

**FR-Z: Social Features** (sharing, profiles, leaderboards)
- **Rationale**: Not core value prop, adds complexity
- **Future**: Post product-market fit

---

### Non-Functional Requirements

#### Performance (Priority P0)

**NFR-1: Response Time**
- **Requirement**: <5 seconds from query to answer (95th percentile)
- **Rationale**: Focus group identified speed as #1 critical factor
- **Measurement**: Server-side logging, client-side analytics

**NFR-2: App Launch Time**
- **Requirement**: <2 sec cold start, <1 sec warm start
- **Rationale**: Mid-game use requires instant access
- **Measurement**: Firebase Performance Monitoring

**NFR-3: Offline Sync**
- **Requirement**: Background sync, non-blocking, <30 MB per game
- **Rationale**: Users won't manually download, must be automatic
- **Measurement**: Data usage tracking, user surveys

#### Security (Priority P0)

**NFR-4: Data Privacy**
- **Requirement**: No PII storage beyond email and library (opt-in)
- **Compliance**: GDPR, CCPA, COPPA (if kids mode)
- **Encryption**: At rest (AES-256), in transit (TLS 1.3)

**NFR-5: Authentication**
- **Requirement**: OAuth 2.0, optional anonymous mode
- **Sessions**: 30-day refresh, secure token storage
- **MFA**: Support for premium tier

#### Scalability (Priority P0)

**NFR-6: Concurrent Users**
- **Requirement**: Support 10K concurrent users at launch, scale to 100K in 6 months
- **Rationale**: Conservative based on 10K Year 1 download target
- **Architecture**: Serverless, auto-scaling

**NFR-7: Database Performance**
- **Requirement**: <100ms query time for 99th percentile
- **Rationale**: Backend must be faster than 5-sec total budget
- **Measurement**: Database monitoring, query profiling

#### Accessibility (Priority P0)

**NFR-8: WCAG Compliance**
- **Requirement**: WCAG 2.1 AA minimum
- **Features**: Screen reader support, keyboard navigation, high contrast mode
- **Testing**: Automated (axe) + manual with assistive tech users

**NFR-9: Platform Requirements**
- **iOS**: 15+, iPhone and iPad
- **Android**: 10+, phones and tablets
- **Rationale**: Covers 95%+ of active devices

#### Reliability (Priority P0)

**NFR-10: Uptime**
- **Requirement**: 99.5% uptime (excluding planned maintenance)
- **Downtime Budget**: ~43 hours/year
- **Monitoring**: Real-time alerting, automated failover

**NFR-11: Crash Rate**
- **Requirement**: <1% crash-free sessions
- **Rationale**: Industry standard for stable apps
- **Measurement**: Firebase Crashlytics

---

### Technical Constraints

**TC-1: Platform Limitations**
- iOS App Store review (2-3 week cycle, strict guidelines)
- Android Google Play (24-48 hour review)
- App size limits (iOS: 200 MB over-the-air, Android: 150 MB APK)

**TC-2: Third-Party Dependencies**
- BoardGameGeek API (rate limits, unofficial, could break)
- YouTube API (quota limits, TOS compliance)
- Cloud hosting (AWS/GCP/Firebase cost scaling)

**TC-3: Content Licensing**
- Publisher permission required for rulebook images
- DMCA compliance for copyrighted material
- Takedown request process needed

**TC-4: Offline Storage**
- Device storage limits (500 games × 30 MB = 15 GB max)
- Intelligent caching required (top 100 auto, rest on-demand)

---

## Success Metrics

### Launch Criteria (MVP "Done" When:)
- [ ] All P0 features complete and tested (FR-1 through FR-5)
- [ ] Performance targets met (NFR-1, NFR-2, <5 sec, <2 sec launch)
- [ ] Security audit passed (NFR-4, NFR-5, penetration testing)
- [ ] Accessibility compliance (NFR-8, WCAG 2.1 AA audit)
- [ ] Beta user feedback >4.0/5.0 (n≥50 users, 2-week test)
- [ ] Crash rate <1% (NFR-11, tested with 1000+ test sessions)
- [ ] Top 100 BGG games covered with verified content

### Product Metrics (KPIs)

#### Acquisition (AARRR: Acquisition)
- **Year 1 Target**: 10,000 downloads
- **Channels**: BGG (40%), YouTube sponsorships (30%), Reddit (20%), Other (10%)
- **CAC Target**: <$12 (LTV / 3)
- **Measurement**: Attribution tracking, install sources

#### Activation (AARRR: Activation)
- **Onboarding Completion**: 80% complete setup
- **First Search**: 60% perform ≥1 search within 24 hours
- **Aha Moment**: 50% perform 3+ searches in first week
- **Measurement**: Funnel analytics, cohort analysis

#### Retention (AARRR: Retention)
- **Monthly Active Users (MAU)**: 40% of downloads
- **Weekly Active Users (WAU)**: 20% of downloads
- **Day 1**: 50%, Day 7: 30%, Day 30: 20%
- **Measurement**: Cohort retention curves

#### Revenue (AARRR: Revenue)
- **Conversion Rate**: 15-20% free to paid
- **ARPU (Average Revenue Per User)**: $4/month
- **LTV (Lifetime Value)**: $40 (assuming 10-month avg lifetime)
- **Churn**: <10% monthly (premium tier)
- **Measurement**: Subscription analytics, payment processing

#### Referral (AARRR: Referral)
- **NPS**: >30 (industry benchmark for good)
- **Viral Coefficient**: 0.3 (30% of users refer a friend)
- **Word-of-Mouth**: 25% of installs from organic/referral
- **Measurement**: NPS surveys, referral tracking

### Product-Market Fit Indicators

**Sean Ellis Test**: 40%+ users say "very disappointed" if product went away
- **Measurement**: Quarterly survey of active users

**Organic Growth**: >10% month-over-month growth without paid acquisition
- **Measurement**: Install source tracking

**CAC < LTV / 3**: Unit economics validate sustainable growth
- **Measurement**: $12 CAC vs $40 LTV = 3.3x ratio ✅

**Retention Curve Flattening**: Cohorts stabilize at 20%+ monthly retention
- **Measurement**: Cohort analysis over 6 months

---

## Competitive Analysis

### Direct Competitors

| Competitor | Users | Pricing | Key Features | Tech Stack (Est.) | Strengths | Weaknesses | Our Advantage |
|------------|-------|---------|--------------|-------------------|-----------|------------|---------------|
| **Dized** | 150K downloads, ~10K MAU | Freemium (Pro $4.99/mo) | Rule search, interactive tutorials, learn mode | React Native, Cloud hosting | Established, tutorial videos | Slow (12-15 sec), requires internet, 500 games only | 3x faster, offline, 2x coverage |
| **RTFM** | 45K downloads | Free (abandoned) | Basic rule lookup | Native iOS | Simple, free | Outdated (2019), ugly UI, no Android | Modern, maintained, cross-platform |
| **BGA Rulebooks** | 2M users (on platform) | Free | Digital play with rules | Web-based | Huge user base, full games | Desktop-only, not mobile-optimized | Mobile-first, offline |
| **YouTube Tutorials** | Watch It Played 1.2M subs | Free (ad-supported) | Video how-to-plays | YouTube platform | High quality, visual | Not searchable mid-game, 15-30 min videos | Instant, text-searchable, <5 sec |
| **BGG Forums** | 2M users | Free | Community Q&A, files | Web forums | Comprehensive, community | Slow, fragmented, requires web browsing | Instant, curated, mobile-optimized |

### Market Positioning

**Our Position**: "The fastest, most accurate offline board game rules companion"

**Positioning Statement**:
> "For board gamers who waste time looking up rules mid-game, RulesMate is a mobile companion that answers rule questions in under 5 seconds, even offline. Unlike Dized or YouTube, we're built for speed and work without internet, so game night flows uninterrupted."

**Competitive Moat** (Defensibility):
1. **Publisher Partnerships**: Official content licensing (hard to replicate)
2. **Speed**: < 5-sec commitment requires tech investment
3. **Offline-First**: Complex sync architecture, not trivial
4. **Network Effects**: User-contributed content (future), game library integration

---

## Technical Considerations

**NOTE**: This section covers high-level architecture and key technologies. Detailed implementation design (the HOW) will be defined in the Technical Design phase.

### High-Level Architecture

**Client**: Native mobile apps (iOS Swift, Android Kotlin) or React Native
**Backend**: Serverless functions (AWS Lambda / Cloud Functions)
**Database**: Managed DB (PostgreSQL on RDS) + Vector search (Pinecone/Weaviate)
**Storage**: Object storage (S3/Cloud Storage) for rulebook images
**Search**: Hybrid (keyword + semantic via embeddings)
**CDN**: CloudFront / Cloud CDN for global latency reduction
**Sync**: Offline-first with conflict resolution (CRDTs or last-write-wins)

### Key Technologies (Recommended by Research)

**Research found these as proven, well-maintained options**:

| Component | Recommended | Alternatives | Rationale |
|-----------|-------------|--------------|-----------|
| **Mobile Framework** | React Native | Native (Swift/Kotlin), Flutter | Cross-platform (iOS + Android from one codebase), 70% code reuse, mature ecosystem, offline-first libraries (WatermelonDB) |
| **Search** | Typesense | Elasticsearch, Meilisearch, Algolia | Open-source, <50ms latency, typo-tolerance, semantic search, offline-capable |
| **Database** | PostgreSQL + Supabase | Firebase Firestore, MongoDB | Relational (structured game/rule data), Supabase adds realtime + auth + storage, proven at scale |
| **Vector Search** | Weaviate | Pinecone, Qdrant | Open-source, hybrid search (keyword + semantic), integrates with Supabase |
| **Offline Sync** | WatermelonDB | Realm, PouchDB, SQLite | Designed for React Native, lazy loading, fast queries, 10K+ downloads/week on npm |
| **Image Caching** | React Native Fast Image | Built-in Image | Disk caching, memory management, priority loading |
| **Voice Recognition** | React Native Voice | Google Speech API, AWS Transcribe | Free, works offline (on-device), good accuracy |
| **Analytics** | Mixpanel + Firebase | Amplitude, PostHog | Mixpanel for product analytics, Firebase for performance/crashes |

### Third-Party Services & APIs

**Integrations**:
- **BoardGameGeek (BGG) API**: Game metadata, user collections (unofficial, rate-limited)
- **YouTube Data API**: Video links and timestamps (10K requests/day free quota)
- **Stripe**: Payment processing (freemium subscriptions)
- **Auth0 / Supabase Auth**: OAuth, user management
- **SendGrid**: Transactional emails

**Content Partnerships** (TBD):
- Publishers (Stonemaier, CMON, etc.): Official rulebook licensing
- Content creators (Watch It Played): Video embedding partnerships

### Open Source Opportunities

**Research identified libraries we can leverage**:

1. **Rule Search**: Build on top of Typesense (OSS) instead of building search engine
2. **Offline Sync**: WatermelonDB handles complex offline-first sync
3. **UI Components**: React Native Paper (Material Design), React Native Elements
4. **PDF Parsing**: pdf.js or pdfkit for rulebook image extraction (if needed)
5. **Image Optimization**: Sharp (Node) for server-side, Fast Image for client

**Cost Savings**: Leveraging OSS reduces build time by estimated 40-60% vs building from scratch.

### Technical Risks (Detailed in Section 9)

1. **Search performance <5 sec**: Requires optimization, caching, CDN
2. **Offline sync complexity**: CRDT or conflict resolution needed
3. **App size (500 games × 30 MB)**: Intelligent caching, on-demand download
4. **BGG API reliability**: Unofficial, could break—need fallback
5. **Publisher content licensing**: Legal complexity, could delay launch

---

## Risks and Mitigations

### Technical Risks

| Risk | Likelihood | Impact | Mitigation Strategy | Owner |
|------|------------|--------|---------------------|-------|
| **Search <5 sec not achievable** | Medium | High | • Pre-index top 1000 queries<br>• CDN for global latency<br>• Caching layer<br>• Load testing early | Engineering |
| **Offline sync bugs (data loss)** | Medium | High | • Use proven library (WatermelonDB)<br>• Extensive testing<br>• Conflict resolution strategy<br>• User data backup | Engineering |
| **App size too large (>500 MB)** | Low | Medium | • Intelligent caching (top 100 auto, rest on-demand)<br>• Image compression (WebP)<br>• Lazy loading | Engineering |
| **BGG API breaks or rate limits** | High | Medium | • Cache BGG data locally<br>• Fallback to manual entry<br>• Consider official BGG partnership | Backend Lead |
| **Publisher licensing blocks content** | High | High | • Start with public domain games<br>• Proactive publisher outreach<br>• User-generated content fallback | Legal/PM |
| **Voice recognition accuracy <90%** | Low | Medium | • Fallback to text search<br>• Improve with usage data<br>• Multiple voice engines (Google, on-device) | ML/Engineering |

### Market Risks

| Risk | Likelihood | Impact | Mitigation Strategy | Owner |
|------|------------|--------|---------------------|-------|
| **Dized improves speed (<5 sec)** | Medium | High | • Maintain speed lead<br>• Differentiate on offline + accuracy<br>• Build publisher partnerships moat | Product/Engineering |
| **Market saturation (new entrants)** | Medium | Medium | • Move fast (launch in 6 months)<br>• Build network effects (user library)<br>• Lock in publisher deals | CEO/PM |
| **User acquisition cost too high (>$12)** | Medium | High | • Optimize conversion funnel<br>• Increase LTV (annual plans, upsells)<br>• Focus on organic/referral | Marketing |
| **Freemium conversion <15%** | Medium | High | • Optimize free tier (enough value to engage)<br>• Clear premium value prop<br>• A/B test pricing and messaging | Product/Marketing |
| **Board game market shrinks** | Low | High | • Diversify to other domains (RPGs, etc.)<br>• Monitor market trends<br>• Pivot if needed | CEO |

### Product Risks

| Risk | Likelihood | Impact | Mitigation Strategy | Owner |
|------|------------|--------|---------------------|-------|
| **MVP too complex (scope creep)** | High | Medium | • Ruthless prioritization (only P0)<br>• Weekly scope reviews<br>• PM owns scope decisions | PM |
| **User adoption low (<60% activation)** | Medium | High | • Usability testing pre-launch<br>• Simple onboarding (1-2 min)<br>• A/B test flows | UX/Product |
| **Accuracy issues (wrong answers)** | Medium | Very High | • Human review all rule entries<br>• Publisher partnerships for official content<br>• User feedback loop for corrections | Domain Expert/PM |
| **Poor retention (<20% monthly)** | Medium | High | • Focus on habit formation (notifications?)<br>• Provide value even when not playing<br>• Engagement loops (stats, library) | Product/Growth |

---

## Out of Scope

### Not in MVP (Explicitly Excluded)

**Strategy Tips / Gameplay Advice**
- **Rationale**: Focus group resistance (45% concerned about "playing for them")
- **Future**: Optional premium feature, clearly labeled as "strategy hints," opt-in only

**Scorekeeping**
- **Rationale**: BG Stats already does this well (500K users), don't compete where we can integrate
- **Future**: Integration over building (link to BG Stats, export data)

**Social Features** (profiles, friends, sharing, leaderboards)
- **Rationale**: Not core value prop, adds significant complexity, unclear value
- **Future**: Post product-market fit, if user research supports

**Digital Game Library / Collection Management**
- **Rationale**: BGG and BG Stats already comprehensive, we're search-focused
- **Future**: Integration (import BGG collection) over building

**Tournament / Event Management**
- **Rationale**: Niche use case (5-10% of users), complex feature
- **Future**: Business tier feature if demand validates

### Not on Roadmap (No Plans)

**Physical Game Sales / Marketplace**
- **Rationale**: Different business model, hardware/logistics complexity

**Live Streaming Integration**
- **Rationale**: Tiny use case, technical complexity

**AR Rule Demonstrations**
- **Rationale**: Cool but gimmicky, unclear value, high dev cost

### Future Consideration (Parking Lot)

**Smart Speaker Integration** (Alexa, Google Home)
- **Rationale**: Hands-free appeal but users already on phones
- **Research Needed**: Do users want this? Technical feasibility?

**AI-Generated House Rules**
- **Rationale**: Could be fun but risky (encourages non-official play)
- **Research Needed**: User demand? Liability?

**Multiplayer Turn Tracking**
- **Rationale**: Could help beginners but adds complexity
- **Research Needed**: Enough value vs simpler solutions?

---

## Timeline and Phases

### MVP Scope (Version 1.0)

**Target Launch**: 6 months from kickoff (July 2024)

**Features**:
- All P0 functional requirements (FR-1 through FR-5)
- All P0 non-functional requirements (performance, security, accessibility)
- Top 100 BGG games coverage
- iOS and Android apps
- Freemium monetization (free + premium tiers)

**Success Criteria**:
- <5 sec search (95th percentile)
- Works offline for top 100 games
- 99.5% uptime, <1% crash rate
- WCAG 2.1 AA compliant
- Beta user rating >4.0/5.0

### Post-MVP Roadmap

**Version 1.1** (MVP + 2 months - September 2024)
- Beginner step-by-step mode (FR-6)
- Video tutorial integration (FR-7)
- Expand to top 200 games
- Performance optimizations based on usage data

**Version 1.2** (MVP + 4 months - November 2024)
- BGG / BG Stats integration (FR-8)
- Multi-game session management for business tier (FR-9)
- Expand to top 500 games
- Advanced search (complex queries, filters)

**Version 2.0** (MVP + 6 months - January 2025)
- Setup assistance (FR-10)
- Publisher partnership content (official FAQs)
- Web app (responsive, desktop experience)
- Internationalization (Spanish, German, French)

### Key Milestones

| Milestone | Target Date | Deliverable |
|-----------|-------------|-------------|
| **Requirements Complete** | Week 0 (Jan 2024) | This PRD approved |
| **Technical Design Complete** | Week 2 | Architecture, tech stack, API specs |
| **Design Mockups** | Week 4 | High-fidelity prototypes, design system |
| **Alpha Build** | Week 8 | Core features working, internal testing |
| **Content Complete** | Week 12 | Top 100 games imported, verified |
| **Beta Launch** | Week 16 | 50-100 beta users, feedback loop |
| **App Store Submission** | Week 22 | iOS + Android submitted for review |
| **Public Launch** | Week 24 (July 2024) | V1.0 live, marketing push |

---

## Appendix

### Research Sources

**User Research**:
- Focus Group Report (2024-01-15)
- BoardGameGeek User Survey 2024 (n=12,847)
- r/boardgames Feedback Threads (2,341 comments analyzed)

**Market Research**:
- Statista: Board Game Market 2024
- Euromonitor: Global Gaming Trends
- App Store Revenue Analysis (Sensor Tower)
- Competitor App Reviews (Dized, RTFM analysis)

**Technical Research**:
- GitHub: Search engines, offline sync libraries
- npm / React Native: Ecosystem analysis
- Stack Overflow: Common implementation patterns
- Technical blogs: Offline-first architecture case studies

### Focus Group Insights Summary

**Top Insights**:
1. Speed is non-negotiable (<5 sec or users won't adopt)
2. Offline mode is critical (78% play in offline scenarios)
3. Accuracy builds trust (one wrong answer breaks all trust)
4. Simple UI essential (3+ taps = abandonment)
5. Avoid over-assistance (don't "play the game for them")

**Validated Features**:
- Instant rule lookup: 100% enthusiasm
- Offline mode: 80% say "must-have"
- Visual rulebook refs: 80% want this
- Voice search: 60% would use

**Pricing Validation**:
- Casual users: $2-4/month or $20-30/year
- Serious gamers: $5/month or $40/year
- Business tier: $20/month validated by cafe owner

### Competitive Feature Matrix

| Feature | RulesMate (Us) | Dized | RTFM | YouTube | BGG |
|---------|----------------|-------|------|---------|-----|
| **Search Speed** | <5 sec | 12-15 sec | 5-10 sec | N/A | 30+ sec |
| **Offline** | ✅ Full | ❌ No | ✅ Full | ❌ No | ❌ No |
| **Game Coverage** | 500 | 500 | 200 | High | Very High |
| **Visual References** | ✅ Rulebook | ✅ Custom | ❌ Text only | ✅ Video | ✅ Files |
| **Voice Search** | ✅ Yes | ❌ No | ❌ No | ❌ No | ❌ No |
| **Mobile Optimized** | ✅ Yes | ✅ Yes | ⚠️ iOS only | ⚠️ Not for search | ❌ No |
| **Beginner Mode** | ✅ Planned | ✅ Yes | ❌ No | ✅ Yes | ❌ No |
| **Pricing** | Freemium | Freemium | Free | Free | Free |

### Glossary

**Terms**:
- **BGG**: BoardGameGeek, largest board game community and database
- **Dized**: Leading competitor, rule app with tutorials
- **RTFM**: "Read The F***ing Manual," competitor rule lookup app
- **BGA**: Board Game Arena, digital platform for playing board games online
- **WCAG**: Web Content Accessibility Guidelines (accessibility standard)
- **MAU**: Monthly Active Users
- **ARPU**: Average Revenue Per User
- **LTV**: Lifetime Value (total revenue per customer)
- **CAC**: Customer Acquisition Cost
- **P0/P1/P2**: Priority levels (0 = must-have, 1 = should-have, 2 = could-have)

---

**Document Status**: ✅ Approved for Technical Design Phase
**Next Step**: Proceed to detailed technical design (architecture, APIs, database schema, deployment)

---

*PRD created by Thursian Engineering Meeting Flow v1.0.0*
*Technical research by Claude-Flow Technical Researcher Agent*
*Date: 2024-01-20*
