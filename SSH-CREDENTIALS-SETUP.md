# SSH Credentials Setup for n8n

This guide shows how to configure SSH credentials in n8n to dynamically use environment variables from your `.env` file.

## Why Use Environment Variables?

- **Repeatable**: Anyone can set their own credentials in `.env` without editing workflows
- **Secure**: Credentials are not hardcoded in the workflow JSON
- **Flexible**: Change credentials without touching n8n configuration

## Configuration Steps

### 1. Ensure .env File is Configured

Your `.env` file should contain:
```env
SSH_USERNAME=automaton
SSH_PASSWORD=automaton
```

### 2. Configure SSH Credential in n8n

1. Open your workflow in n8n (http://localhost:5678)
2. Click on the "Ask Claude" SSH node
3. In the credentials section, click **"Create New Credential"**
4. Fill in the form:

| Field | Value | Notes |
|-------|-------|-------|
| **Credential Name** | `Claude Runner SSH` | Any descriptive name |
| **Host** | `claude-runner` | Service name from docker-compose.yml |
| **Port** | `22` | Standard SSH port |
| **Username** | `={{$env.SSH_USERNAME}}` | ⚠️ Use this exact syntax! |
| **Password** | `={{$env.SSH_PASSWORD}}` | ⚠️ Use this exact syntax! |

### 3. Important Syntax Notes

- **Environment variable syntax:** `={{$env.VARIABLE_NAME}}`
- The `=` at the start tells n8n this is an expression
- The `{{ }}` wraps the expression
- The `$env.` prefix accesses environment variables
- **Do NOT** use quotes around the expression

### 4. Test the Connection

1. After entering the credentials, click **"Save"**
2. n8n should automatically test the connection
3. You should see a success message

### 5. Activate Your Workflow

1. Click **"Save"** on the workflow
2. Toggle the workflow to **"Active"**

## Troubleshooting

### "Connection failed" Error

**Check:**
- Is the claude-runner container running? `docker ps`
- Are the env vars in your `.env` file (no quotes)?
- Did you restart n8n after updating `.env`? `docker-compose restart n8n`

**Test manually:**
```bash
docker exec n8n-orchestration printenv | grep SSH
```

Should show:
```
SSH_USERNAME=automaton
SSH_PASSWORD=automaton
```

### "Expression error" in Credentials

**Check:**
- Did you use the exact syntax `={{$env.SSH_USERNAME}}`?
- No quotes around the expression
- Expression starts with `=`

### Container Not Accessible

**Test SSH manually:**
```bash
# From Windows/host
ssh -p 2222 automaton@localhost

# From inside n8n container
docker exec -it n8n-orchestration sh
apk add openssh-client
ssh automaton@claude-runner
```

## What Happens Behind the Scenes

1. Docker Compose reads `.env` file
2. Passes `SSH_USERNAME` and `SSH_PASSWORD` to both containers:
   - **claude-runner**: Creates user with these credentials
   - **n8n**: Makes variables available as `$env.SSH_USERNAME` and `$env.SSH_PASSWORD`
3. n8n evaluates the expressions in credentials at runtime
4. SSH connection is made with the evaluated values

## Changing Credentials

To change SSH credentials:

1. Update `.env` file:
   ```env
   SSH_USERNAME=mynewuser
   SSH_PASSWORD=mynewpassword
   ```

2. Rebuild containers:
   ```bash
   docker-compose down
   docker-compose up -d
   ```

3. n8n credentials will automatically use the new values (no changes needed in n8n UI!)

## Security Notes

- These credentials are for the **Docker container only**, not your host system
- The container is isolated and only accessible via the Docker network
- For production, use stronger passwords and consider SSH keys instead
