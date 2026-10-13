# Small Field plugin for Claude Code

Deploy and manage your Small Field apps from Claude Code. The plugin connects Claude to your
Small Field MCP server and adds the `/small-field:deploy` skill.

## Install

In Claude Code:

1. `/plugin marketplace add thesmallfield/ai-plugin`
2. `/plugin install small-field@thesmallfield`
3. When asked for **Console URL**, paste your Console address, e.g.
   `https://appsadmin.perkinswill.com`
4. `/mcp`, pick **small-field**, choose **Authenticate** and sign in with your Small Field
   account.
5. Try `/small-field:deploy`.

To change the Console URL later, open `/config`.

## What is inside

- `.mcp.json`: the MCP server at `<Console URL>/mcp`.
- `skills/deploy`: how to deploy a repo and manage releases, logs, jobs and secrets.

Check the plugin locally with `claude plugin validate --strict .`.
