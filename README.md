# Small Field plugin for Claude Code

Deploy and manage your Small Field apps from Claude Code. The plugin connects Claude to your
Small Field MCP server and adds skills that teach Claude how to work with Small Field.

## Install

In Claude Code:

1. `/plugin marketplace add thesmallfield/ai-plugin`
2. `/plugin install small-field@thesmallfield`
3. When asked for **Console URL**, paste your Console address, e.g.
   `https://console.example.com`
4. `/mcp`, pick **small-field**, choose **Authenticate** and sign in with your Small Field
   account.
5. Try `/small-field:deploy`.

To change the Console URL later, open `/config`.

## What is inside

- `.mcp.json`: the MCP server at `<Console URL>/mcp`.
- `skills/deploy`: deploy a repo and manage releases, logs, jobs, secrets and maintenance.
- `skills/smallfield-json`: write or fix the `smallfield.json` manifest.
- `skills/secrets-and-databases`: secrets, env vars and Postgres.
- `skills/jobs`: scheduled and on-demand jobs.
- `skills/connected-apps`: let one app call another app's API or job.
- `skills/troubleshoot`: failed releases, logs, maintenance and rollback.
- `skills/docs`: answer questions from the Small Field docs.

## Docs

The developer docs live in your Console and need sign-in. The skills read them through the MCP
tools `list_docs` and `read_doc`. In a signed-in browser, open `<Console URL>/docs`, or the raw
Markdown at `<Console URL>/docs/llms.txt`, `<Console URL>/docs/llms-full.txt` and
`<Console URL>/docs/<slug>.md`.

Check the plugin locally with `claude plugin validate --strict .`.
