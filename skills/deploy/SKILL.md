---
name: deploy
description: Deploy the current repo to Small Field with the small-field MCP tools, then set secrets, run a job, promote or roll back. Use when the user wants to deploy or ship an app, publish a new version, set a secret, run a job now, or promote a release to production.
---

# Deploy to Small Field

Use only the `small-field` MCP tools; `tools/list` describes each tool's inputs. If they are
missing or return 401, ask the user to sign in to the connector (in Claude Code: `/mcp`, pick
small-field, **Authenticate**). For how deploys and releases behave, `read_doc` `get-started`
and `logs-and-releases`.

## Deploy the current repo

1. Read `smallfield.json` at the repo root: it is the `manifest`, and its `project` is the
   project name. If it is missing or wrong, use the `smallfield-json` skill first.
2. `create_project` with that name (safe if it already exists).
3. Run `git status --porcelain`. If it prints anything, tell the user uncommitted changes are not
   deployed and ask them to commit first.
4. Zip the repo without `node_modules`, `.git`, build output or `.env` files, e.g.
   `git archive --format=zip -o /tmp/app.zip HEAD`, and get its size in bytes.
5. `create_upload` with `project` and `sizeBytes`, then upload:
   `curl -fsS -X PUT -H 'content-type: application/zip' --data-binary @/tmp/app.zip "<url>"`.
6. `deploy` with `project`, `uploadId` and the `manifest`.
7. Poll `get_release` every 10 seconds until `live` or `failed`. On `live`, show the web address.
   On `failed`, use the `troubleshoot` skill.

Cannot run `curl` (for example, a sandbox without internet)? Send a small app with `deploy_files`
instead of steps 4 to 6.

## After the deploy

- **Secrets:** ask the user for each value, `set_secret`, then deploy again (`read_doc` `secrets`
  says when a secret takes effect). `list_secret_names` shows what is set. Never print a value.
  Ask before `remove_secret`.
- **Run a job now:** `run_job` with `project` and `job`, then tell the user where to watch it
  (`read_doc` `jobs`).
- **Promote:** `promote` with `project`, `from` and `to`, then poll `get_release`.
- **Roll back:** `rollback` with `project` (no `releaseId` = the release before), then poll
  `get_release`.

## Example

User: "Deploy this." Read `smallfield.json` (`project: "notes"`), `create_project` `notes`, zip,
`create_upload`, PUT the zip, `deploy`, poll `get_release` until `live`, and reply with the address.
