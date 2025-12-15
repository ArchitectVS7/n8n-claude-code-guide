
# 02 — Installation & Environment Preparation  
*Preparing Your Terminal for Synthetic Colleagues*

Before you can speak with synthetic engineers, you must configure the environment through which they emerge.

The Thursian system rests on:

- **Claude-Flow** (the orchestration brain)  
- **Node.js** (the substrate for its runtime)  
- **Your project repository** structured with Thursian conventions  
- **The `.thursian/` directory**, where minds store plans, reviews, and decisions  

---

## Installing Claude-Flow

In Windows PowerShell, the simplest way to ensure smooth execution is a global installation:

```powershell
npm install -g claude-flow@alpha
