# Small Field plugin for Claude and ChatGPT

Deploy and manage your Small Field apps from Claude or ChatGPT. The plugin connects the assistant
to the Small Field MCP server and adds four skills:

- `docs`: answer a Small Field question from the docs.
- `smallfield-json`: write or fix the `smallfield.json` manifest.
- `deploy`: deploy the current repo, then set secrets, run a job, promote or roll back.
- `troubleshoot`: a failed release, logs, maintenance and rollback.

## The rule for skills

**A skill says which doc slug to read; it never restates a rule a doc states.** The docs live in
the Console (`list_docs`, `read_doc`) and are the one place a rule is written. A skill is the
steps: which tool to call, which page to read first, what to tell the user. Skills are
instructions only: one `SKILL.md` per folder, no scripts, at most five (ChatGPT's limit).

The same `skills/` folder is everything: this repo is the Claude marketplace, each release has
the Claude and ChatGPT zips, and the Small Field MCP server serves the skills over MCP (it pins a
commit of this repo in `apps/mcp/skills.ref`).

## Install

**Your own Small Field install:** open the Console, profile menu, **Connect AI assistant**, and
click **Download plugin**. That zip already points at your install.

**Claude Code** (any install):

1. `/plugin marketplace add thesmallfield/ai-plugin`
2. `/plugin install small-field@thesmallfield`
3. When asked for **Console URL**, paste your Console address, e.g. `https://console.example.com`
4. `/mcp`, pick **small-field**, choose **Authenticate** and sign in.
5. Try `/small-field:deploy`.

**claude.ai and Claude Desktop:** download `small-field-claude-plugin.zip` from the
[latest release](https://github.com/thesmallfield/ai-plugin/releases/latest), then
**Customize > Plugins > Add > Upload plugin**.

**ChatGPT:** add the connector by URL (**Add custom MCP server**, then **Create as a plugin**).
`small-field-chatgpt-plugin.zip` from the latest release is for an admin who submits the plugin
in the OpenAI developer dashboard.

## Release

Merging to `main` publishes a GitHub release `v0.0.1-<short sha>` with both zips, built by
`scripts/release.sh`. The MCP URL in the zips comes from the `SAAS_MCP_URL` repository variable
(a placeholder until it is set).

Check locally with `claude plugin validate --strict .` and `./scripts/release.sh`.
