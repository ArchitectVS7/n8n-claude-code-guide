# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an **n8n + Claude Code orchestration system** that enables AI-powered automation workflows triggered via Discord, webhooks, or direct SSH access. The system bridges n8n workflow automation with Claude Code's AI capabilities, allowing Claude to execute tasks on a Linux/WSL environment with full file system access.

## Architecture

The system consists of three main components that communicate over a private network:

1. **Discord Bot** (`discord-bot-docker/bot.js`)
   - Listens for `!claude` commands in Discord
   - Forwards messages to n8n webhook via HTTP POST
   - Built with discord.js, minimal dependencies

2. **n8n Workflow Orchestrator**
   - Receives webhooks from Discord bot or external sources
   - Manages workflow logic and session state
   - Executes Claude Code commands via SSH
   - Returns responses via Discord webhooks or other outputs

3. **Claude Code Runner** (SSH target)
   - Ubuntu environment with Claude Code installed
   - Accessible via SSH (localhost:22 in WSL, or claude-runner:22 in Docker)
   - Has full read/write access to mounted file systems
   - Executes AI commands with `--dangerously-skip-permissions` for automation

**Data Flow:**
```
Discord → Discord Bot → n8n Webhook → Parse → Generate UUID → SSH to Claude → Discord Response
```

## Deployment Options

The system supports two deployment modes:

### WSL Deployment
- All components run directly in WSL Ubuntu
- Started via `wsl-startup-script.sh` or individual terminal sessions
- Uses localhost for SSH connections
- Better file system performance
- Requires manual process management

### Docker Deployment (Recommended)
- All components containerized with docker-compose.yml
- One-command startup: `docker-compose up -d`
- Auto-restart on failures/reboots
- Isolated network: `orchestration-net`
- Uses service names for inter-container communication (e.g., `claude-runner` not `localhost`)

## Key Configuration Files

### Environment Variables (.env)
```env
DISCORD_BOT_TOKEN=          # Required for Discord bot
ANTHROPIC_API_KEY=          # Optional if using Pro subscription
SSH_USERNAME=automaton      # SSH user created inside Docker container
SSH_PASSWORD=automaton      # SSH password for container user
NGROK_AUTHTOKEN=            # Optional for external webhooks
```

**IMPORTANT:**
- Never include quotes around values in .env files
- SSH credentials are for the Docker container user, NOT your local Windows/WSL credentials
- The container creates a fresh user with these credentials at startup

### Docker Compose (docker-compose.yml)
- **Services:** n8n, claude-runner, discord-bot, ngrok (optional)
- **Networks:** orchestration-net (bridge)
- **Volumes:**
  - `n8n-data`: Persists workflows, credentials, execution history
  - `claude-data`: Persists Claude auth and config
  - `C:/dev:/workspace:rw`: Mounts local files for Claude access

### Workflow Templates (workflows/)
- `1-basic-claude-test.json`: Simple SSH command test
- `2-claude-with-sessions.json`: Session management example
- `3-system-health-monitor.json`: Monitoring automation
- `4-discord-webhook-simple.json`: Complete Discord integration

## Common Commands

### Docker Operations
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs -f
docker logs discord-bot
docker logs n8n-orchestration
docker logs claude-code-runner

# Restart specific service
docker-compose restart discord-bot

# Enter Claude container
docker exec -it claude-code-runner bash

# SSH to Claude runner (from host)
ssh -p 2222 automaton@localhost  # Password: automaton
```

### WSL Operations
```bash
# Start orchestration system
./wsl-startup-script.sh

# Start components individually
n8n                    # Terminal 1
cd ~/discord-bot && node bot.js   # Terminal 2
sudo service ssh start # SSH server
```

### Windows Batch Scripts
```cmd
start-orchestration.bat  # Launch WSL components
start-docker.bat         # Launch Docker stack
stop-docker.bat          # Stop Docker stack
```

## Working with n8n Workflows

### SSH Node Configuration

**For Docker deployment, use environment variable expressions:**

In n8n SSH credentials, configure:
- Host: `claude-runner` (service name, NOT localhost)
- Port: `22`
- Username: `={{$env.SSH_USERNAME}}`
- Password: `={{$env.SSH_PASSWORD}}`

**Important:** The `={{ }}` syntax reads from environment variables in your `.env` file.

See [SSH-CREDENTIALS-SETUP.md](SSH-CREDENTIALS-SETUP.md) for detailed setup instructions.

**For WSL deployment:**
- Host: `localhost`
- Port: `22`
- Username: Your WSL username
- Password: Your WSL password

### Claude Command Patterns

```bash
# Basic command (print mode)
claude -p "your prompt here"

# With session management
claude -p "your prompt" --session-id {{ $json.sessionId }}

# Resume session
claude -r --session-id {{ $json.sessionId }} -p "follow-up prompt"

# With file context
cd /workspace/your-project && claude -p "analyze this codebase"

# Enable tools and agents (dangerous mode)
claude --dangerously-skip-permissions -p "deploy agents to analyze X"
```

### Session Management
- Generate UUIDs using the provided JavaScript snippet in workflows
- Sessions persist for the duration of the conversation
- Use `-r` flag to resume existing sessions
- Session IDs should be passed through workflow nodes

## File System Access

### Docker Mounts
| Local Path | Container Path | Purpose |
|------------|----------------|---------|
| `C:\dev` | `/workspace` | Main workspace (read/write) |
| `./workflows` | `/backup/workflows` | Workflow backups (read-only) |
| `./discord-bot-docker` | `/app` | Discord bot code (read-only) |

### Example Workflow Commands
```bash
# Access local projects
cd /workspace/GIT/my-project && claude -p "review recent changes"

# Clone repositories
cd /workspace && git clone https://github.com/user/repo

# Run project commands
cd /workspace/my-app && npm test
```

## Discord Bot Integration

### Bot Configuration
- Prefix: `!claude` (configurable via BOT_PREFIX env var)
- Required Discord Intents: MESSAGE CONTENT INTENT, SERVER MEMBERS INTENT
- Webhook forwarding: HTTP POST to n8n at `/webhook/discord-claude`

### Message Flow
1. User sends `!claude Tell me a joke`
2. Bot extracts message content after prefix
3. Forwards to n8n with metadata (username, userId, channelId, timestamp)
4. n8n executes workflow and sends response via Discord webhook
5. Response appears in Discord channel from webhook

## Troubleshooting Guidelines

### Discord Bot Issues
- Verify MESSAGE CONTENT INTENT is enabled in Discord Developer Portal
- Check bot token has no quotes in .env
- Restart: `docker-compose restart discord-bot`
- Check logs: `docker logs discord-bot`

### n8n Workflow Issues
- Ensure workflow is activated (toggle ON)
- Verify SSH credentials match deployment type (claude-runner vs localhost)
- Test webhook: `curl -X POST http://localhost:5678/webhook/discord-claude -d '{"content":"test"}'`
- Check executions in n8n UI for error details

### Claude SSH Issues
- **Docker:** Use service name `claude-runner`, not `localhost`
- **WSL:** Ensure SSH service is running: `sudo service ssh status`
- Test authentication: Enter container and run `claude --version`
- Re-authenticate: `claude auth`

### File Access Issues
- Verify volume mounts in docker-compose.yml
- Check paths use forward slashes: `C:/dev` not `C:\dev`
- Ensure :rw or :ro permissions are set
- Test inside container: `docker exec -it claude-code-runner ls /workspace`

## Security Considerations

- The `--dangerously-skip-permissions` flag bypasses all safety checks
- Only use for trusted automation workflows
- Never expose n8n webhooks publicly without authentication
- Store sensitive credentials in .env, not in code
- .gitignore includes .env to prevent credential leaks

## Development Workflow

### Adding New Workflows
1. Design workflow in n8n UI at http://localhost:5678
2. Export workflow: Settings → Export
3. Save to `workflows/` directory with descriptive name
4. Update documentation if adding new patterns

### Modifying Discord Bot
1. Edit `discord-bot-docker/bot.js`
2. Restart: `docker-compose restart discord-bot`
3. Monitor: `docker logs -f discord-bot`

### Updating Docker Configuration
1. Edit docker-compose.yml
2. Rebuild: `docker-compose up -d --build`
3. Verify: `docker-compose ps`

## Backup and Migration

### Backup Volumes
```bash
# Backup n8n data (workflows, credentials)
docker run --rm -v automaton_n8n-data:/data -v C:/backup:/backup ubuntu tar czf /backup/n8n-backup.tar.gz /data

# Backup Claude data (auth)
docker run --rm -v automaton_claude-data:/data -v C:/backup:/backup ubuntu tar czf /backup/claude-backup.tar.gz /data
```

### Migration to New Machine
1. Copy entire automaton folder
2. Copy backup files
3. Install Docker Desktop on new machine
4. Create .env with credentials
5. Restore volumes (reverse tar command)
6. Run `docker-compose up -d`

## Documentation Structure

All detailed documentation is in `Orchestration-Manual/`:
- `00-COMPLETE-SETUP-GUIDE.md`: Complete A-Z WSL setup
- `DOCKER-LAUNCH-QUICKSTART.md`: Docker deployment guide
- `DISCORD-BOT-SETUP.md`: Detailed Discord configuration
- `Part02-Workflow-Examples.md`: Example automation patterns
- `Part05-Troubleshooting.md`: Common issues and solutions
- `CONTAINERIZATION-FAQ.md`: Docker vs WSL comparison

## Important Notes

- Claude Code requires Anthropic Pro subscription OR API key
- First Docker startup takes 5-10 minutes to download images
- SSH credentials differ between Docker (automaton/automaton) and WSL (your username/password)
- All containers auto-restart unless stopped with `docker-compose down`
- n8n UI accessible at http://localhost:5678
- ngrok tunnel requires authtoken and `--profile external` to start
