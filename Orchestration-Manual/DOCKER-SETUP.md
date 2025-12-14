# Docker Containerization Guide

## Overview

This guide containerizes your entire orchestration system into Docker containers for one-click startup.

## Benefits of Docker Setup

✅ **One Command Start:** `docker-compose up -d`
✅ **Auto-Restart:** Containers restart automatically if they crash or system reboots
✅ **Isolated Environment:** Clean, reproducible setup
✅ **Full File Access:** Your entire `C:/dev` folder mounted in containers
✅ **Internet Access:** Git clone, npm install, API calls all work
✅ **Easy Backup:** Export/import volumes for migration

---

## Containers Included

| Container | Purpose | Always Needed? |
|-----------|---------|----------------|
| **n8n** | Workflow orchestration | ✅ Yes |
| **claude-runner** | Claude Code with SSH | ✅ Yes |
| **discord-bot** | Discord integration | ✅ Yes (for Discord) |
| **ngrok** | External webhooks | ❌ Optional |

**Total:** 3 containers (4 with ngrok)

---

## Prerequisites

1. **Docker Desktop for Windows** installed
   - Download: https://www.docker.com/products/docker-desktop
   - Make sure WSL 2 backend is enabled

2. **Your tokens ready:**
   - Discord Bot Token
   - Anthropic API Key (optional if using Pro)
   - ngrok token (optional)

---

## Setup Steps

### Step 1: Install Docker Desktop

1. Download Docker Desktop for Windows
2. Run installer
3. During setup, ensure "Use WSL 2 instead of Hyper-V" is checked
4. Restart computer when prompted
5. Launch Docker Desktop
6. Wait for it to fully start (whale icon in system tray)

---

### Step 2: Configure Environment Variables

**1. Copy the template:**

```powershell
# In PowerShell
cd C:\dev\GIT\automaton
copy .env.template .env
```

**2. Edit .env file:**

Open `C:\dev\GIT\automaton\.env` in Notepad and fill in:

```env
# Required for Claude Code in containers
ANTHROPIC_API_KEY=your_actual_api_key

# Required for Discord bot
DISCORD_BOT_TOKEN=your_actual_bot_token

# Optional - only if you need external webhooks
NGROK_AUTHTOKEN=your_ngrok_token_if_you_want_it
```

**Save and close.**

---

### Step 3: Start the Containers

**In PowerShell:**

```powershell
cd C:\dev\GIT\automaton
docker-compose up -d
```

**What happens:**
- Downloads Docker images (first time only, ~5-10 minutes)
- Creates containers
- Starts all services
- Returns to prompt

**Check status:**

```powershell
docker-compose ps
```

You should see:
```
NAME                    STATUS
n8n-orchestration       Up
claude-code-runner      Up
discord-bot             Up
```

---

### Step 4: Verify Everything is Running

**1. Check n8n:**
- Open browser: http://localhost:5678
- Should see n8n login/interface

**2. Check Discord bot:**

```powershell
docker logs discord-bot
```

Should show:
```
✓ Discord bot logged in as Automaton#9499
✓ Forwarding to: http://n8n:5678/webhook/discord-claude
✓ Listening for: !claude <message>
```

**3. Test in Discord:**

```
!claude Hello from Docker!
```

---

### Step 5: Import Your Existing Workflow

**Since containers are fresh, you need to import your workflow:**

1. Open n8n: http://localhost:5678
2. Create account (first time only)
3. Import workflow:
   - Click "..." menu
   - Import from File
   - Select: `C:\dev\GIT\automaton\workflows\4-discord-webhook-simple.json`
4. Configure SSH credentials:
   - Host: `claude-runner`
   - Port: `22`
   - Username: `automaton`
   - Password: `automaton`
5. Configure Discord webhook URL (your webhook from Discord)
6. Save and Activate

---

## File Access from Containers

### Your Local Files are Mounted:

**In n8n or Claude containers:**
- `/workspace` = `C:\dev` (full access)
- `/workspace/GIT/automaton` = This project
- `/workspace/your-repo` = Any repo in C:\dev

**Example Claude command in n8n:**

```bash
cd /workspace/your-repo && claude -p "Analyze this codebase"
```

**Git operations work:**

```bash
cd /workspace && git clone https://github.com/user/repo
```

---

## Daily Usage

### Start Everything:

```powershell
cd C:\dev\GIT\automaton
docker-compose up -d
```

### Stop Everything:

```powershell
docker-compose down
```

### View Logs:

```powershell
# All containers
docker-compose logs

# Specific container
docker logs discord-bot
docker logs n8n-orchestration
docker logs claude-code-runner

# Follow logs (live)
docker logs -f discord-bot
```

### Restart a Container:

```powershell
docker-compose restart discord-bot
docker-compose restart n8n
```

---

## Auto-Start on System Boot

Docker Desktop can auto-start containers on boot.

**In Docker Desktop:**
1. Settings → General
2. ✅ Check "Start Docker Desktop when you log in"
3. Your containers will auto-start (because restart: unless-stopped)

**Or use Task Scheduler:**

Create `C:\dev\GIT\automaton\start-docker-on-boot.bat`:

```batch
@echo off
cd C:\dev\GIT\automaton
docker-compose up -d
```

Then:
1. Open Task Scheduler
2. Create Basic Task
3. Trigger: At log on
4. Action: Start a program
5. Program: `C:\dev\GIT\automaton\start-docker-on-boot.bat`

---

## Troubleshooting

### Container Won't Start

**Check logs:**
```powershell
docker logs container-name
```

**Restart container:**
```powershell
docker-compose restart container-name
```

### n8n Can't Connect to Claude

**Verify SSH:**
```powershell
# Enter the Claude container
docker exec -it claude-code-runner bash

# Test SSH
ssh automaton@localhost
# Password: automaton
```

### Discord Bot Not Responding

**Check bot is running:**
```powershell
docker logs discord-bot
```

**Check token is correct:**
```powershell
# Edit .env file
notepad .env

# Restart bot
docker-compose restart discord-bot
```

### File Access Issues

**Verify mount:**
```powershell
# Enter n8n container
docker exec -it n8n-orchestration sh

# Check if files are there
ls /workspace
ls /workspace/GIT
```

---

## Advanced: Enable ngrok (Optional)

**Only if you need external webhooks from the internet.**

**Start with ngrok:**

```powershell
docker-compose --profile external up -d
```

**Check ngrok URL:**

```powershell
# Visit: http://localhost:4040
# Or check logs:
docker logs ngrok-tunnel
```

---

## Data Persistence

**Your data is stored in Docker volumes:**

### Backup Volumes:

```powershell
# Backup n8n data
docker run --rm -v automaton_n8n-data:/data -v C:/backup:/backup ubuntu tar czf /backup/n8n-backup.tar.gz /data

# Backup Claude data
docker run --rm -v automaton_claude-data:/data -v C:/backup:/backup ubuntu tar czf /backup/claude-backup.tar.gz /data
```

### Restore Volumes:

```powershell
docker run --rm -v automaton_n8n-data:/data -v C:/backup:/backup ubuntu tar xzf /backup/n8n-backup.tar.gz -C /
```

---

## Migration to Another Machine

**1. On old machine:**

```powershell
# Export workflows
# In n8n UI: Settings → Export all workflows

# Backup volumes
docker-compose down
docker run --rm -v automaton_n8n-data:/data -v C:/backup:/backup ubuntu tar czf /backup/n8n.tar.gz /data
docker run --rm -v automaton_claude-data:/data -v C:/backup:/backup ubuntu tar czf /backup/claude.tar.gz /data

# Copy to new machine:
# - C:\dev\GIT\automaton folder
# - C:\backup\*.tar.gz files
```

**2. On new machine:**

```powershell
# Copy files
# Install Docker Desktop
cd C:\dev\GIT\automaton

# Restore volumes
docker volume create automaton_n8n-data
docker volume create automaton_claude-data
docker run --rm -v automaton_n8n-data:/data -v C:/backup:/backup ubuntu tar xzf /backup/n8n.tar.gz -C /
docker run --rm -v automaton_claude-data:/data -v C:/backup:/backup ubuntu tar xzf /backup/claude.tar.gz -C /

# Start
docker-compose up -d
```

---

## Comparison: Docker vs WSL

| Feature | WSL Setup | Docker Setup |
|---------|-----------|--------------|
| **Startup** | 3 manual terminals | 1 command |
| **Auto-restart** | Manual scripts | Built-in |
| **File access** | Direct | Via mounts |
| **Internet** | Yes | Yes |
| **Isolation** | Shared WSL | Isolated containers |
| **Portability** | WSL-specific | Works anywhere |
| **Setup complexity** | Medium | Low (after first setup) |

---

## Quick Reference

### Essential Commands:

```powershell
# Start all containers
docker-compose up -d

# Stop all containers
docker-compose down

# View status
docker-compose ps

# View logs
docker-compose logs -f

# Restart a service
docker-compose restart discord-bot

# Enter a container
docker exec -it n8n-orchestration sh
docker exec -it claude-code-runner bash

# Update containers (after changing docker-compose.yml)
docker-compose up -d --build
```

### Service URLs:

- **n8n:** http://localhost:5678
- **ngrok (if enabled):** http://localhost:4040
- **SSH to Claude:** `ssh -p 2222 automaton@localhost` (password: automaton)

---

## Next Steps

1. ✅ Test the Docker setup
2. ✅ Import your workflows
3. ✅ Configure SSH credentials in n8n
4. ✅ Test Discord integration
5. ✅ Set up auto-start (optional)
6. ✅ Backup your volumes regularly

---

**You now have a fully containerized, production-ready orchestration system!**
