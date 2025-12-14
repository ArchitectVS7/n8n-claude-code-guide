# Quick Start Guide

## Your System is Ready!

You've completed the initial setup. Here's how to get started:

---

## Current Status ✅

- WSL2 Ubuntu: Installed and running
- Node.js: v20.19.6 installed
- Claude Code: v2.0.69 installed and authenticated
- SSH Server: Configured on localhost:22
- n8n: v1.123.5 installed
- Discord Bot: Created and invited to server

**Next Step**: Complete Discord integration (see ORCHESTRATION-MANUAL.md Step 14)

---

## Two Ways to Start Your System

### Option 1: Quick Start (Current Setup - WSL)

#### First Time Setup:
1. **Install WSL startup script:**
   ```bash
   # In WSL terminal
   cp /mnt/c/dev/GIT/automaton/wsl-startup-script.sh ~/start-orchestration.sh
   chmod +x ~/start-orchestration.sh
   ```

2. **Test the script:**
   ```bash
   ~/start-orchestration.sh
   ```

#### Daily Use:
**Double-click:** `start-orchestration.bat`

This will:
- Start SSH server
- Launch n8n
- Start ngrok tunnel (if configured)
- Open n8n in your browser

---

### Option 2: Docker (Recommended for Production)

#### First Time Setup:
1. **Copy environment template:**
   ```bash
   cp .env.template .env
   ```

2. **Edit .env file** with your actual credentials:
   - Anthropic API key (if using API instead of Pro)
   - ngrok auth token
   - Discord bot token and webhook URL

3. **Install Docker Desktop for Windows** (if not installed)

#### Daily Use:
**Double-click:** `start-docker.bat`

This will:
- Start all containers (n8n, Claude runner, ngrok)
- Auto-restart on crashes
- Persist data between restarts

**To stop:** Double-click `stop-docker.bat`

---

## What You Can Do Right Now

### 1. Test Your Basic Workflow

Already created! In n8n:
1. Open workflow (should be saved)
2. Click "Test workflow"
3. See Claude respond through SSH

### 2. Complete Discord Integration

Follow **ORCHESTRATION-MANUAL.md** starting at **Step 14**:
- Install ngrok
- Configure Discord webhooks
- Build Discord conversation workflow

### 3. Try Example Workflows

Copy these examples from **ORCHESTRATION-MANUAL.md Part 2**:
- **System Health Monitor**: Auto-check your system every 15 minutes
- **Code Review Assistant**: Auto-review git commits
- **Documentation Generator**: Auto-generate docs from code
- **Multi-Agent Research**: Deploy multiple Claude instances

---

## Useful Commands

### Check if Everything is Running:
```bash
# In WSL
ps aux | grep n8n        # Check n8n
sudo service ssh status   # Check SSH
curl http://localhost:5678  # Test n8n web interface
```

### Stop Everything:
```bash
# In WSL
pkill n8n
pkill ngrok
sudo service ssh stop
```

### View Logs:
```bash
# In WSL
tail -f /tmp/n8n.log
tail -f /tmp/ngrok.log
```

---

## Access Your Services

- **n8n Dashboard**: http://localhost:5678
- **ngrok Inspector**: http://localhost:4040
- **Claude Code**: `wsl -d Ubuntu` then `claude`

---

## Get Help

- **Full Manual**: See `ORCHESTRATION-MANUAL.md`
- **Original Guide**: See `README.md`
- **Troubleshooting**: ORCHESTRATION-MANUAL.md Part 5

---

## Next Steps

1. ✅ Complete Discord integration (Step 14-17 in manual)
2. ✅ Try the example workflows
3. ✅ Create your first custom automation
4. ✅ Set up automatic startup (if desired)
5. ✅ Consider moving to Docker for easier management

---

**You're 90% done! Just finish the Discord webhook setup and you'll have a complete orchestration system.**

Questions? Check the troubleshooting section in the manual or review the video resources in README.md.
