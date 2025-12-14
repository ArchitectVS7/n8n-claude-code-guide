# Claude Code + n8n Orchestration System - Technical Manual

## Current System Status

### ✅ Completed Components
- WSL2 Ubuntu installed and running
- Node.js v20.19.6 installed in WSL2
- Claude Code 2.0.69 installed and authenticated (Anthropic Pro)
- OpenSSH server installed and configured in WSL2
- n8n 1.123.5 installed and running
- SSH connection tested (localhost:22)
- Basic Claude Code workflow created with session management
- Discord bot created and invited to server

### 🔄 Current Position
You are at Step 14: Installing ngrok to expose n8n webhook publicly for Discord integration.

### 📋 Remaining Steps to Complete

---

## Part 1: Complete Discord Integration (Resume Here)

### Step 14: Install and Configure ngrok

**Purpose**: Expose your local n8n webhook to the internet so Discord can send messages to it.

**In a NEW WSL terminal window:**

```bash
# 1. Open new PowerShell and enter WSL
wsl -d Ubuntu

# 2. Install ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update
sudo apt install ngrok -y

# 3. Sign up for ngrok (if not already done)
# Visit: https://dashboard.ngrok.com/signup
# Copy your authtoken from the dashboard

# 4. Authenticate ngrok (replace YOUR_TOKEN with actual token)
ngrok config add-authtoken YOUR_TOKEN_HERE

# 5. Start ngrok tunnel
ngrok http 5678
```

**Expected Output:**
```
Forwarding  https://abc123.ngrok.io -> http://localhost:5678
```

**Copy the HTTPS URL** (e.g., `https://abc123.ngrok.io`) - you'll use this in Discord.

---

### Step 15: Configure Discord Webhook

**1. In your Discord server:**
- Right-click the channel where you want the bot to respond
- Click **"Edit Channel"**
- Click **"Integrations"** → **"Webhooks"**
- Click **"New Webhook"**
- Name it "Claude Response" or similar
- **Copy the Webhook URL** (looks like: `https://discord.com/api/webhooks/...`)
- Click **"Save Changes"**

**2. Set up Discord to send messages to n8n:**

Since Discord doesn't have native message forwarding to external webhooks, we'll use a Discord bot with a simple listener. Alternative: Use a Discord bot framework or manually trigger workflows.

**Simpler Approach - Manual Trigger via Discord Slash Command:**

We'll create a workflow that you can trigger by posting a message in Discord, then use Discord's webhook to post responses back.

---

### Step 16: Build Complete Discord Workflow in n8n

**Workflow Structure:**
```
[Webhook Trigger] → [Code: Parse Discord Data] → [Code: Generate UUID]
    → [Execute Command: Claude Initial] → [Discord Webhook: Send Response]
    → [Wait for User Input] → [If Continue] → [Execute Command: Claude Resume]
    → [Loop back to Discord Response]
```

**1. Create New Workflow:**
- In n8n, create new workflow named "Discord Claude Bot"

**2. Add Webhook Node:**
- Add **Webhook** trigger node
- HTTP Method: `POST`
- Path: `discord-claude`
- Keep other defaults

**3. Add Code Node (Parse Discord):**
```javascript
// Extract message from Discord webhook payload
const content = $input.item.json.content || $input.item.json.message;
const username = $input.item.json.username || $input.item.json.author?.username;

return [{
  json: {
    message: content,
    user: username,
    timestamp: new Date().toISOString()
  }
}];
```

**4. Add Code Node (Generate UUID):**
```javascript
const uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
  const r = Math.random() * 16 | 0;
  const v = c == 'x' ? r : (r & 0x3 | 0x8);
  return v.toString(16);
});

return [{
  json: {
    sessionId: uuid,
    message: $input.item.json.message,
    user: $input.item.json.user
  }
}];
```

**5. Add Execute Command Node (Claude):**
- Credentials: Use existing SSH localhost credentials
- Command:
```bash
claude -p "{{ $json.message }}" --session-id {{ $json.sessionId }} --dangerously-skip-permissions
```

**6. Add HTTP Request Node (Discord Webhook Response):**
- Method: `POST`
- URL: Your Discord Webhook URL from Step 15
- Body Content Type: `JSON`
- Body:
```json
{
  "content": "**Claude Response:**\n```\n{{ $json.output }}\n```\n\n_Session ID: {{ $json.sessionId }}_"
}
```

**7. Save and Activate Workflow**

---

### Step 17: Test Discord Integration

**1. Send test message to your n8n webhook:**

Using curl in WSL or PowerShell:
```bash
curl -X POST https://YOUR_NGROK_URL.ngrok.io/webhook/discord-claude \
  -H "Content-Type: application/json" \
  -d '{"content":"Tell me a joke about orchestration"}'
```

**2. Check Discord channel** - you should see Claude's response

**3. For ongoing conversations**, modify workflow to:
- Store session IDs (use n8n's built-in database or Redis)
- Resume with `-r` flag based on user ID
- Add conversation timeout logic

---

## Part 2: Workflow Examples

### Example 1: System Health Monitor

**Use Case**: Automatically monitor system health and report to Discord

**Workflow:**
```
[Schedule Trigger: Every 15 min] → [Execute Command: System Check]
    → [If: Issues Detected] → [Discord Alert]
```

**Execute Command Node:**
```bash
claude --dangerously-skip-permissions -p "Check system health: CPU usage, memory, disk space, running services. Report any issues. Keep response under 500 characters."
```

**Application:**
- Server monitoring
- Automated DevOps alerts
- Proactive issue detection
- Resource optimization recommendations

---

### Example 2: Code Review Assistant

**Use Case**: Automatically review code commits and provide feedback

**Workflow:**
```
[Webhook: GitHub Push] → [Code: Extract Diff] → [Execute Command: Claude Review]
    → [HTTP Request: Post GitHub Comment]
```

**Execute Command Node:**
```bash
cd /path/to/repo && git diff HEAD~1 && claude --dangerously-skip-permissions -p "Review this git diff for: security vulnerabilities, performance issues, code quality, best practices. Provide specific recommendations. Keep under 1000 characters."
```

**Application:**
- Automated code review
- Security vulnerability scanning
- Code quality enforcement
- Team knowledge sharing

---

### Example 3: Documentation Generator

**Use Case**: Automatically generate documentation from codebase changes

**Workflow:**
```
[Manual Trigger] → [Code: Get File List] → [Execute Command: Analyze Code]
    → [Execute Command: Generate Docs] → [Write to File] → [Slack/Discord Notification]
```

**Execute Command Node 1 (Analyze):**
```bash
cd /path/to/project && claude --dangerously-skip-permissions -p "Analyze the codebase structure in src/ directory. Identify main components, their purposes, and relationships. Create a high-level architecture overview."
```

**Execute Command Node 2 (Generate):**
```bash
claude -r --session-id {{ $json.sessionId }} -p "Based on your analysis, generate comprehensive markdown documentation including: architecture overview, component descriptions, API endpoints, setup instructions, and usage examples."
```

**Application:**
- Automatic documentation updates
- Onboarding new team members
- API documentation maintenance
- Architecture decision records

---

### Example 4: Multi-Agent Research System

**Use Case**: Deploy multiple Claude instances to research different aspects of a topic

**Workflow:**
```
[Manual Trigger] → [Code: Generate 3 UUIDs] → [Split into 3 Branches]
    Branch 1: [Claude: Technical Analysis]
    Branch 2: [Claude: Market Research]
    Branch 3: [Claude: Competitor Analysis]
    → [Merge Results] → [Claude: Synthesize] → [Discord Report]
```

**Execute Command Nodes (Parallel):**

Branch 1:
```bash
claude --dangerously-skip-permissions -p "{{ $json.topic }} - Provide deep technical analysis: architecture, technologies, implementation challenges, scalability considerations." --session-id {{ $json.sessionId1 }}
```

Branch 2:
```bash
claude --dangerously-skip-permissions -p "{{ $json.topic }} - Market research: target audience, market size, competitors, pricing models, growth opportunities." --session-id {{ $json.sessionId2 }}
```

Branch 3:
```bash
claude --dangerously-skip-permissions -p "{{ $json.topic }} - Competitor analysis: key players, their strengths/weaknesses, market positioning, differentiation opportunities." --session-id {{ $json.sessionId3 }}
```

**Final Synthesis:**
```bash
claude --dangerously-skip-permissions -p "Synthesize these three analyses into a comprehensive strategic report with actionable recommendations: Technical: {{ $node['Branch1'].json.output }} Market: {{ $node['Branch2'].json.output }} Competitors: {{ $node['Branch3'].json.output }}" --session-id {{ $json.synthesisId }}
```

**Application:**
- Strategic planning
- Product research
- Competitive intelligence
- Investment analysis

---

## Part 3: Easy Startup Solutions

### Option A: WSL Auto-Start Scripts (Quick Solution)

**Problem**: Need to manually start SSH and n8n after every reboot.

**Solution**: Create startup scripts

**1. Create startup script in WSL:**

```bash
# In WSL terminal
nano ~/start-orchestration.sh
```

**Add this content:**
```bash
#!/bin/bash

echo "Starting Claude Code Orchestration System..."

# Start SSH server
sudo service ssh start
echo "✓ SSH server started"

# Start n8n in background
n8n &
echo "✓ n8n started on http://localhost:5678"

# Start ngrok (if you have authtoken configured)
ngrok http 5678 &
echo "✓ ngrok tunnel started"

echo ""
echo "Orchestration system is ready!"
echo "n8n: http://localhost:5678"
echo "Check ngrok URL: http://localhost:4040"
echo ""
echo "To stop: pkill n8n && pkill ngrok"
```

**Make it executable:**
```bash
chmod +x ~/start-orchestration.sh
```

**2. Create Windows batch file for one-click start:**

Create `C:\dev\GIT\automaton\start-orchestration.bat`:
```batch
@echo off
echo Starting Orchestration System...
wsl -d Ubuntu bash ~/start-orchestration.sh
echo.
echo System started! Press any key to open n8n in browser...
pause
start http://localhost:5678
```

**Usage**: Double-click `start-orchestration.bat` to start everything!

---

### Option B: Docker Containerization (Recommended for Production)

**Advantages:**
- One-click start/stop
- Consistent environment
- Easy backup and migration
- Isolated from host system
- No manual service management

**1. Create Docker Compose Configuration:**

Create `C:\dev\GIT\automaton\docker-compose.yml`:

```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n-orchestration
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=changeme
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - WEBHOOK_URL=http://localhost:5678/
      - GENERIC_TIMEZONE=America/New_York
    volumes:
      - n8n-data:/home/node/.n8n
      - ./workflows:/home/node/.n8n/workflows
    restart: unless-stopped
    networks:
      - orchestration-net

  claude-runner:
    image: ubuntu:22.04
    container_name: claude-code-runner
    command: /bin/bash -c "
      apt update &&
      apt install -y curl openssh-server sudo &&
      curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&
      apt-get install -y nodejs &&
      npm install -g @anthropic-ai/claude-code &&
      service ssh start &&
      tail -f /dev/null"
    ports:
      - "2222:22"
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    volumes:
      - claude-data:/root
      - ./projects:/workspace
    restart: unless-stopped
    networks:
      - orchestration-net

  ngrok:
    image: ngrok/ngrok:latest
    container_name: ngrok-tunnel
    command: http n8n:5678
    ports:
      - "4040:4040"
    environment:
      - NGROK_AUTHTOKEN=${NGROK_AUTHTOKEN}
    depends_on:
      - n8n
    restart: unless-stopped
    networks:
      - orchestration-net

volumes:
  n8n-data:
  claude-data:

networks:
  orchestration-net:
    driver: bridge
```

**2. Create environment file:**

Create `C:\dev\GIT\automaton\.env`:
```env
ANTHROPIC_API_KEY=your_anthropic_api_key_here
NGROK_AUTHTOKEN=your_ngrok_token_here
```

**3. One-click startup script:**

Create `C:\dev\GIT\automaton\start-docker.bat`:
```batch
@echo off
echo Starting Orchestration System with Docker...
cd /d C:\dev\GIT\automaton
docker-compose up -d
echo.
echo System started!
echo n8n: http://localhost:5678
echo ngrok dashboard: http://localhost:4040
echo.
pause
```

**4. Stop script:**

Create `C:\dev\GIT\automaton\stop-docker.bat`:
```batch
@echo off
echo Stopping Orchestration System...
cd /d C:\dev\GIT\automaton
docker-compose down
echo System stopped.
pause
```

**Usage:**
- Double-click `start-docker.bat` to start
- Double-click `stop-docker.bat` to stop
- All data persists between restarts

---

### Option C: Hybrid Approach (Current WSL + Auto-Start)

**For your current setup without Docker:**

**1. Configure SSH to start automatically in WSL:**

```bash
# In WSL terminal
sudo nano /etc/wsl.conf
```

**Add:**
```ini
[boot]
command="service ssh start"
```

**2. Create Windows Task Scheduler entry:**

- Open Task Scheduler
- Create Basic Task: "Start Orchestration System"
- Trigger: At log on
- Action: Start a program
  - Program: `wsl.exe`
  - Arguments: `-d Ubuntu bash ~/start-orchestration.sh`

**3. Auto-start n8n as systemd service (in WSL):**

```bash
# Create systemd service file
sudo nano /etc/systemd/system/n8n.service
```

**Add:**
```ini
[Unit]
Description=n8n - Workflow Automation
After=network.target

[Service]
Type=simple
User=venomous
ExecStart=/usr/bin/n8n
Restart=always
Environment="N8N_PORT=5678"

[Install]
WantedBy=multi-user.target
```

**Enable:**
```bash
sudo systemctl enable n8n
sudo systemctl start n8n
```

---

## Part 4: Advanced Configuration

### Session Management with Redis

**For persistent session tracking across workflows:**

**1. Install Redis in WSL:**
```bash
sudo apt install redis-server -y
sudo service redis-server start
```

**2. In n8n workflow, use Redis nodes:**
- Store session IDs with user identifiers
- Retrieve sessions for conversation continuity
- Set TTL for automatic cleanup

**Example Code Node (Store Session):**
```javascript
const Redis = require('redis');
const client = Redis.createClient();

await client.connect();
await client.set(`session:${$json.userId}`, $json.sessionId, {
  EX: 3600 // 1 hour expiry
});

return $input.all();
```

---

### Claude Code Skills Integration

**Create custom skills for specialized tasks:**

**1. Check available skills:**
```bash
claude skills list
```

**2. Use skills in workflows:**
```bash
claude --dangerously-skip-permissions -p "Use your unifi skill to check network status" --session-id {{ $json.sessionId }}
```

**3. Create custom skill (example):**

See Claude Code documentation for skill development:
- https://docs.anthropic.com/claude-code/skills

---

### Error Handling and Retry Logic

**Add error handling to workflows:**

**1. Add Error Trigger node:**
- Catches failures from any node
- Can retry or send alerts

**2. Add If node for response validation:**
```javascript
// Check if Claude response is valid
const output = $json.output;
if (!output || output.includes('error')) {
  return [null, $input.item]; // Route to error path
}
return [$input.item, null]; // Route to success path
```

**3. Add retry logic with loop:**
- Set maximum retry count
- Exponential backoff
- Alert after max retries exceeded

---

## Part 5: Troubleshooting Guide

### SSH Connection Issues

**Symptom**: n8n can't connect via SSH

**Solutions:**
```bash
# Check SSH is running
sudo service ssh status

# Restart SSH
sudo service ssh restart

# Check SSH port
sudo netstat -tulpn | grep :22

# Test connection manually
ssh localhost
```

---

### Claude Code Not Found

**Symptom**: `claude: command not found`

**Solutions:**
```bash
# Find Claude installation
which claude

# If not found, reinstall
sudo npm install -g @anthropic-ai/claude-code

# Or use full path in n8n
/usr/local/bin/claude -p "test"
```

---

### n8n Not Starting

**Symptom**: Can't access http://localhost:5678

**Solutions:**
```bash
# Check if n8n is running
ps aux | grep n8n

# Check port is available
sudo netstat -tulpn | grep :5678

# Restart n8n
pkill n8n
n8n

# Check for errors in logs
n8n 2>&1 | tee n8n.log
```

---

### ngrok Tunnel Issues

**Symptom**: Discord can't reach webhook

**Solutions:**
```bash
# Restart ngrok
pkill ngrok
ngrok http 5678

# Check ngrok dashboard
# Visit: http://localhost:4040

# Verify tunnel is active
curl https://your-ngrok-url.ngrok.io/webhook-test/from-discord
```

---

### Session Not Persisting

**Symptom**: Claude doesn't remember previous conversation

**Solutions:**
- Verify session ID is being passed correctly
- Use `-r` flag for resume
- Check session hasn't expired (Claude sessions have time limits)
- Store session ID in n8n workflow data or database

---

### Discord Webhook Not Responding

**Symptom**: No response in Discord channel

**Solutions:**
- Verify Discord webhook URL is correct
- Check webhook hasn't been deleted
- Test webhook directly:
```bash
curl -X POST "YOUR_DISCORD_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '{"content":"Test message"}'
```
- Check n8n workflow execution logs

---

## Part 6: Production Considerations

### Security Best Practices

1. **Never commit credentials to git:**
   - Use `.env` files
   - Add `.env` to `.gitignore`
   - Use n8n's credential encryption

2. **Restrict SSH access:**
   - Use SSH keys instead of passwords
   - Disable root login
   - Configure firewall rules

3. **Secure webhooks:**
   - Use HTTPS only
   - Implement webhook signature verification
   - Rate limit webhook endpoints

4. **Claude Code permissions:**
   - Only use `--dangerously-skip-permissions` when necessary
   - Review tool access requests
   - Monitor Claude's actions

---

### Performance Optimization

1. **n8n Performance:**
   - Enable execution data pruning
   - Use production mode
   - Configure database properly (PostgreSQL for production)

2. **Claude Code:**
   - Limit response lengths for faster processing
   - Use session management to reduce context switching
   - Deploy multiple Claude instances for parallel processing

3. **Resource Management:**
   - Monitor CPU/memory usage
   - Set workflow timeouts
   - Implement queue systems for high-volume workflows

---

### Backup and Recovery

**Backup n8n workflows:**
```bash
# Export all workflows
# In n8n UI: Settings → Export → All workflows

# Or backup data directory
cp -r ~/.n8n ~/n8n-backup-$(date +%Y%m%d)
```

**Backup Claude Code auth:**
```bash
# Claude auth is stored in
~/.config/@anthropic-ai/claude-code/
```

**Docker backup:**
```bash
# Backup volumes
docker-compose down
docker run --rm -v n8n-data:/data -v $(pwd):/backup ubuntu tar czf /backup/n8n-backup.tar.gz /data
```

---

## Part 7: Next Steps and Enhancements

### Recommended Enhancements

1. **Add more messaging platforms:**
   - Slack integration
   - Microsoft Teams
   - Telegram bot

2. **Implement job queues:**
   - Bull/BullMQ for task scheduling
   - Redis for queue management
   - Worker processes for parallel execution

3. **Create dashboard:**
   - Grafana for metrics
   - Monitor workflow success rates
   - Track Claude usage and costs

4. **Add voice integration:**
   - Whisper for speech-to-text
   - Send voice notes to Discord → transcribe → Claude → response

5. **Build skill library:**
   - Custom Claude Code skills for your use cases
   - Share skills across workflows
   - Version control skills in git

---

## Quick Reference Commands

### Start System (WSL Method)
```bash
# Terminal 1: Start services
wsl -d Ubuntu
~/start-orchestration.sh

# Terminal 2 (if using ngrok separately):
wsl -d Ubuntu
ngrok http 5678
```

### Start System (Docker Method)
```bash
cd C:\dev\GIT\automaton
docker-compose up -d
```

### Stop System
```bash
# WSL Method
pkill n8n
pkill ngrok
sudo service ssh stop

# Docker Method
docker-compose down
```

### Check Status
```bash
# n8n
ps aux | grep n8n
curl http://localhost:5678

# SSH
sudo service ssh status

# ngrok
curl http://localhost:4040/api/tunnels
```

### Useful n8n Commands
```bash
# Update n8n
sudo npm update -g n8n

# Clear n8n cache
rm -rf ~/.n8n/cache

# Reset n8n database (WARNING: deletes all workflows)
rm ~/.n8n/database.sqlite
```

---

## Support and Resources

- **Claude Code Docs**: https://docs.anthropic.com/claude-code
- **n8n Docs**: https://docs.n8n.io
- **n8n Community**: https://community.n8n.io
- **Discord Developer**: https://discord.com/developers/docs
- **ngrok Docs**: https://ngrok.com/docs

---

## Appendix: File Structure

```
C:\dev\GIT\automaton\
├── README.md                      # Original guide
├── ORCHESTRATION-MANUAL.md        # This file
├── .env                           # Environment variables (don't commit!)
├── .gitignore                     # Git ignore file
├── docker-compose.yml             # Docker configuration
├── start-orchestration.bat        # Windows startup script (WSL)
├── start-docker.bat               # Windows startup script (Docker)
├── stop-docker.bat                # Windows stop script (Docker)
└── workflows/                     # n8n workflow exports
    ├── basic-claude-test.json
    ├── discord-bot.json
    ├── system-monitor.json
    └── code-review.json
```

---

**Version**: 1.0
**Last Updated**: 2025-12-13
**Author**: Automaton Project
**Status**: In Progress - Discord integration pending completion
