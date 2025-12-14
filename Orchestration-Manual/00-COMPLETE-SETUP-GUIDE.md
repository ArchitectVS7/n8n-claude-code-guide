# Complete n8n + Claude Code Orchestration Setup Guide

> **Complete A-Z guide for building a Discord-controlled Claude Code orchestration system**

**What You'll Build:**
- Discord bot that responds to `!claude` commands
- n8n workflow orchestration
- Claude Code AI assistant integration
- Full automation system accessible from Discord

**Time Required:** 2-3 hours for complete setup

---

## Table of Contents

- [Part 1: Environment Setup](#part-1-environment-setup)
- [Part 2: Core Installation](#part-2-core-installation)
- [Part 3: n8n Setup](#part-3-n8n-setup)
- [Part 4: Discord Bot Creation](#part-4-discord-bot-creation)
- [Part 5: Discord Bot Installation](#part-5-discord-bot-installation)
- [Part 6: n8n Workflow Configuration](#part-6-n8n-workflow-configuration)
- [Part 7: Testing](#part-7-testing)
- [Part 8: Docker Containerization (Optional)](#part-8-docker-containerization-optional)

---

## Part 1: Environment Setup

### Prerequisites

**You need:**
- Windows 10/11
- Anthropic Claude Pro subscription OR API key
- Discord account
- Basic command line familiarity

### Step 1.1: Install WSL2 with Ubuntu

**Open PowerShell as Administrator:**

```powershell
# Check if WSL is installed
wsl --version

# If not installed, install WSL
wsl --install

# If already installed, set default to WSL2
wsl --set-default-version 2

# Install Ubuntu (if not already installed)
wsl --install -d Ubuntu

# List installed distributions
wsl -l -v
```

**Expected output:**
```
  NAME              STATE           VERSION
* Ubuntu            Running         2
```

**After installation:**
- Ubuntu will ask you to create a username and password
- **Remember this password** - you'll need it for `sudo` commands

**Test it works:**
```powershell
wsl -d Ubuntu
```

You should see a Ubuntu bash prompt like: `username@computer:~$`

---

## Part 2: Core Installation

### Step 2.1: Install Node.js in WSL

**In WSL terminal:**

```bash
# Update package lists
sudo apt update

# Install Node.js 20.x (LTS)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

**Expected output:**
- Node: v20.x.x
- npm: 10.x.x or higher

### Step 2.2: Install Claude Code

```bash
# Install Claude Code globally
sudo npm install -g @anthropic-ai/claude-code

# Verify installation
claude --version
```

**Expected output:** `2.0.69 (Claude Code)` or higher

### Step 2.3: Authenticate Claude Code

```bash
claude auth
```

**This will:**
- Open a browser window
- Ask you to log in with your Anthropic Pro account
- Authenticate Claude Code

**After successful auth:**
- You'll see "Successfully authenticated!"
- Close the browser window

### Step 2.4: Install SSH Server

```bash
# Install OpenSSH server
sudo apt install openssh-server -y

# Start SSH service
sudo service ssh start

# Verify SSH is running
sudo service ssh status
```

**Expected:** `sshd is running`

**Test SSH connection:**
```bash
ssh localhost
# Type 'yes' when asked
# Enter your WSL password
# Type 'exit' to close the SSH session
```

---

## Part 3: n8n Setup

### Step 3.1: Install n8n

```bash
# Install n8n globally
sudo npm install -g n8n

# Verify installation
n8n --version
```

**Expected:** `1.x.x` (version number)

**Note:** Installation takes 5-10 minutes with many warnings - this is normal!

### Step 3.2: Start n8n

**Keep this terminal running:**

```bash
n8n
```

**Expected output:**
```
Editor is now accessible via: http://localhost:5678/
```

**Open browser:** http://localhost:5678

### Step 3.3: Create n8n Account

**First time setup:**
1. Enter your email (any email - doesn't need verification for local use)
2. Enter your name
3. Create a password (remember this!)
4. Click through any setup wizards

**You'll see:** n8n dashboard

---

## Part 4: Discord Bot Creation

### Step 4.1: Create Discord Application

**Go to:** https://discord.com/developers/applications

1. Click **"New Application"**
2. Name it (e.g., "Claude Orchestrator")
3. Click **"Create"**

### Step 4.2: Create Bot

**In your application:**

1. Click **"Bot"** in left sidebar
2. Click **"Add Bot"** → **"Yes, do it!"**
3. Under "Token", click **"Reset Token"**
4. **Copy the token** and save it somewhere safe

### Step 4.3: Enable Intents

**Critical step:**

1. Scroll to **"Privileged Gateway Intents"**
2. Enable: ✅ **MESSAGE CONTENT INTENT**
3. Enable: ✅ **SERVER MEMBERS INTENT** (optional)
4. Click **"Save Changes"**

### Step 4.4: Invite Bot to Server

1. Click **"OAuth2"** in left sidebar
2. Click **"URL Generator"**
3. Under **SCOPES**, check: `bot`
4. Under **BOT PERMISSIONS**, check:
   - Send Messages
   - Read Messages/View Channels
   - Read Message History
5. **Copy the Generated URL** at bottom
6. Paste URL in browser
7. Select your Discord server
8. Click **"Authorize"**

**Your bot should now appear in your Discord server (offline for now)**

### Step 4.5: Create Discord Webhook

**In your Discord server:**

1. Right-click the channel where you want Claude responses
2. Click **"Edit Channel"**
3. Click **"Integrations"** → **"Webhooks"**
4. Click **"New Webhook"**
5. Name it: "Claude Response"
6. **Copy the Webhook URL** (looks like `https://discord.com/api/webhooks/...`)
7. Click **"Save Changes"**

**Save this URL - you'll need it for n8n!**

---

## Part 5: Discord Bot Installation

### Step 5.1: Create Bot Directory

**Open a NEW WSL terminal** (keep n8n running in the first one):

```bash
# In new WSL terminal
cd ~
mkdir discord-bot
cd discord-bot
```

### Step 5.2: Initialize Node Project

```bash
npm init -y
npm install discord.js axios dotenv
```

### Step 5.3: Create Environment File

```bash
nano .env
```

**Paste this (replace with your actual values):**

```env
DISCORD_BOT_TOKEN=your_bot_token_from_step_4.2
N8N_WEBHOOK_URL=http://localhost:5678/webhook/discord-claude
BOT_PREFIX=!claude
```

**To save in nano:**
- Press **Ctrl+O**, then **Enter** to save
- Press **Ctrl+X** to exit

**Paste shortcuts for nano:**
- Right-click to paste
- OR Ctrl+Shift+V

### Step 5.4: Create Bot Script

```bash
nano bot.js
```

**Paste this complete code:**

```javascript
require('dotenv').config();
const { Client, GatewayIntentBits } = require('discord.js');
const axios = require('axios');

// Bot configuration
const BOT_TOKEN = process.env.DISCORD_BOT_TOKEN;
const WEBHOOK_URL = process.env.N8N_WEBHOOK_URL || 'http://localhost:5678/webhook/discord-claude';
const BOT_PREFIX = process.env.BOT_PREFIX || '!claude';

// Create Discord client
const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

// When bot is ready
client.once('ready', () => {
  console.log('========================================');
  console.log(`✓ Discord bot logged in as ${client.user.tag}`);
  console.log(`✓ Forwarding to: ${WEBHOOK_URL}`);
  console.log(`✓ Listening for: ${BOT_PREFIX} <message>`);
  console.log('========================================');
  console.log('Bot is ready! Send messages with:', BOT_PREFIX);
  console.log('Example: !claude Tell me a joke');
  console.log('');
});

// When message is received
client.on('messageCreate', async (message) => {
  // Ignore messages from bots
  if (message.author.bot) return;

  // Check if message starts with bot prefix
  if (!message.content.startsWith(BOT_PREFIX)) return;

  // Extract the actual message (remove prefix)
  const userMessage = message.content.slice(BOT_PREFIX.length).trim();

  // Ignore empty messages
  if (!userMessage) {
    message.reply('Please provide a message after the command. Example: `!claude Hello`');
    return;
  }

  console.log(`[${new Date().toISOString()}] Message from ${message.author.username}: ${userMessage}`);

  // Show typing indicator
  await message.channel.sendTyping();

  try {
    // Forward to n8n webhook
    const response = await axios.post(WEBHOOK_URL, {
      content: userMessage,
      username: message.author.username,
      userId: message.author.id,
      channelId: message.channel.id,
      messageId: message.id,
      timestamp: new Date().toISOString()
    }, {
      headers: {
        'Content-Type': 'application/json'
      },
      timeout: 120000 // 2 minute timeout for Claude
    });

    console.log(`✓ Forwarded to n8n successfully`);

  } catch (error) {
    console.error('Error forwarding to n8n:', error.message);
    message.reply('⚠️ Sorry, there was an error processing your request. Make sure n8n is running!');
  }
});

// Error handling
client.on('error', (error) => {
  console.error('Discord client error:', error);
});

process.on('unhandledRejection', (error) => {
  console.error('Unhandled promise rejection:', error);
});

// Login to Discord
console.log('Starting Discord bot...');
client.login(BOT_TOKEN).catch((error) => {
  console.error('Failed to login to Discord:', error.message);
  console.error('Please check your DISCORD_BOT_TOKEN in .env file');
  process.exit(1);
});
```

**Save:** Ctrl+O, Enter, Ctrl+X

### Step 5.5: Start Discord Bot

```bash
node bot.js
```

**Expected output:**
```
========================================
✓ Discord bot logged in as YourBotName#1234
✓ Forwarding to: http://localhost:5678/webhook/discord-claude
✓ Listening for: !claude <message>
========================================
Bot is ready! Send messages with: !claude
```

**Keep this terminal running!**

**Verify in Discord:** Your bot should now show as **online** (green dot)

---

## Part 6: n8n Workflow Configuration

### Step 6.1: Import Workflow

**In n8n browser (http://localhost:5678):**

1. Click the **"..." menu** (three dots in top right)
2. Select **"Import from File"**
3. Navigate to: `C:\dev\GIT\automaton\workflows\4-discord-webhook-simple.json`
4. Click **"Open"** to import

### Step 6.2: Configure Webhook Node

**Click on the "Webhook" node (first node):**

- **HTTP Method:** POST
- **Path:** `discord-claude`

**This should already be correct from the import.**

### Step 6.3: Configure Parse Discord Message Node

**Click on "Parse Discord Message" Code node:**

**Replace code with:**

```javascript
// Extract from body
const content = $input.item.json.body.content;
const username = $input.item.json.body.username;
const userId = $input.item.json.body.userId;

return [{
  json: {
    message: content,
    user: username,
    userId: userId
  }
}];
```

### Step 6.4: Configure Generate UUID Node

**Click on "Generate Session ID" Code node:**

**Code should be:**

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

### Step 6.5: Configure SSH/Ask Claude Node

**Click on "Ask Claude" (Execute Command/SSH) node:**

**Create new SSH credentials:**
1. Click "Create New Credential"
2. Fill in:
   - **Host:** `localhost`
   - **Port:** `22`
   - **Username:** Your WSL username
   - **Authentication:** Password
   - **Password:** Your WSL password
3. Click "Save"

**Command:**
```bash
claude -p "{{ $json.message }}" --session-id {{ $json.sessionId }}
```

### Step 6.6: Configure Send to Discord Node

**Click on "Send to Discord" (HTTP Request) node:**

**Settings:**
- **Method:** POST
- **URL:** Your Discord Webhook URL from Step 4.5

**Body Content Type:** JSON

**Specify Body:** Using Fields Below

**Add field:**
- **Name:** `content`
- **Value:** `{{ $('Ask Claude').item.json.stdout }}`

### Step 6.7: Save and Activate

1. Click **"Save"** at top
2. Name it: "Discord Claude Bot"
3. Toggle **"Active"** switch to ON (blue/green)

**You should see:** "Workflow activated"

---

## Part 7: Testing

### Your Terminal Setup

**You should have 3 terminals running:**

1. **Terminal 1 (n8n):** Shows n8n output
2. **Terminal 2 (Discord bot):** Shows bot activity
3. **Terminal 3:** Available for other commands

### Step 7.1: Send Test Message

**In Discord, in the channel with your bot, type:**

```
!claude Tell me a joke about automation
```

### Step 7.2: Watch the Flow

**Terminal 2 (Discord bot) should show:**
```
[2025-12-14T...] Message from YourName: Tell me a joke about automation
✓ Forwarded to n8n successfully
```

**n8n browser:**
1. Click "Executions" in left sidebar
2. You should see a new execution
3. All nodes should show green checkmarks ✓

**Discord channel:**
- Within 5-10 seconds, Claude's response appears!
- Posted by your "Claude Response" webhook

### Step 7.3: Try More Commands

```
!claude Explain quantum computing in simple terms
!claude What's the best way to learn programming?
!claude Write a haiku about automation
```

**🎉 Success! Your orchestration system is working!**

---

## Part 8: Docker Containerization (Optional)

**For easier startup and auto-restart, see:**
- **DOCKER-LAUNCH-QUICKSTART.md** - Quick Docker setup
- **CONTAINERIZATION-FAQ.md** - Docker vs WSL comparison

**Benefits of Docker:**
- One command startup: `docker-compose up -d`
- Auto-restart on crashes/reboots
- Easy backup and migration
- Full file system access maintained

---

## Troubleshooting

### Discord Bot Not Seeing Messages

**Check:**
- Is MESSAGE CONTENT INTENT enabled in Discord Developer Portal?
- Is bot in the same channel where you're typing?
- Did you type `!claude` with the exclamation mark?

**Fix:**
- Go to Discord Developer Portal → Bot → Enable MESSAGE CONTENT INTENT
- Restart bot: Ctrl+C in Terminal 2, then `node bot.js`

### n8n Not Receiving Webhook

**Check:**
- Is workflow activated? (toggle should be blue/green)
- Is webhook path correct? (should be `discord-claude`)

**Fix:**
- Toggle workflow OFF then ON
- Click "Save"

### Claude Not Responding

**Check:**
- Are SSH credentials correct in n8n?
- Is Claude Code authenticated? Run `claude --version` in WSL

**Fix:**
- Test SSH: `ssh localhost` in WSL
- Re-authenticate Claude: `claude auth`

### Discord Webhook Not Posting

**Check:**
- Is Discord webhook URL correct?
- Did you paste the full URL?

**Fix:**
- Test webhook manually:
```bash
curl -X POST "YOUR_DISCORD_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '{"content":"Test message"}'
```

---

## Daily Usage

### Starting Everything

**Terminal 1 - n8n:**
```bash
wsl -d Ubuntu
n8n
```

**Terminal 2 - Discord Bot:**
```bash
wsl -d Ubuntu
cd ~/discord-bot
node bot.js
```

### Stopping Everything

- Press **Ctrl+C** in each terminal

### Auto-Start (Optional)

See **Part03-Easy-Startup.md** for:
- Startup scripts
- One-click batch files
- systemd services

---

## Next Steps

1. ✅ Test different Claude commands
2. ✅ Explore example workflows in Part02-Workflow-Examples.md
3. ✅ Set up Docker for easier management (DOCKER-LAUNCH-QUICKSTART.md)
4. ✅ Create custom workflows for your use cases
5. ✅ Share with friends (see Part07-Appendix.md for sharing guide)

---

## Architecture Diagram

```
┌──────────────────────────────────────────────────────────┐
│                       Windows 10/11                       │
│                                                           │
│  ┌──────────┐                  ┌─────────────────────┐  │
│  │ Discord  │ ───────────────► │   Discord Bot       │  │
│  │ (You)    │  !claude message │   (WSL Terminal 2)  │  │
│  └──────────┘                  └──────┬──────────────┘  │
│                                       │                  │
│                            HTTP POST to localhost:5678   │
│                                       ▼                  │
│                          ┌────────────────────────────┐  │
│                          │   n8n Workflow             │  │
│                          │   (WSL Terminal 1)         │  │
│                          │   - Webhook Trigger        │  │
│                          │   - Parse Message          │  │
│                          │   - Generate Session ID    │  │
│                          └────────┬───────────────────┘  │
│                                   │                      │
│                              SSH to localhost:22        │
│                                   ▼                      │
│                          ┌────────────────────────────┐  │
│                          │   Claude Code              │  │
│                          │   (WSL)                    │  │
│                          │   - AI Processing          │  │
│                          │   - Generate Response      │  │
│                          └────────┬───────────────────┘  │
│                                   │                      │
│                              Response back to n8n        │
│                                   ▼                      │
│                          ┌────────────────────────────┐  │
│                          │   n8n Send to Discord      │  │
│                          │   (HTTP Request)           │  │
│                          └────────┬───────────────────┘  │
│                                   │                      │
│                       Discord Webhook POST              │
│                                   ▼                      │
│  ┌──────────┐                  ┌─────────────────────┐  │
│  │ Discord  │ ◄─────────────── │   Discord Webhook   │  │
│  │ (You)    │  Claude response │   (Cloud)           │  │
│  └──────────┘                  └─────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

---

**Congratulations! You've built a complete AI orchestration system!** 🎉

**For Docker setup, continue to:** DOCKER-LAUNCH-QUICKSTART.md
