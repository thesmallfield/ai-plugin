---
name: deploy
description: Deploy and manage Small Field apps with the small-field MCP tools. Use when the user wants to deploy an app, check a release, read logs, run a job, or manage secrets on Small Field.
---

# Deploy and manage Small Field apps

Use only the `small-field` MCP tools. If they are missing or return 401, ask the user to run
`/mcp`, pick small-field and choose Authenticate.

## Tools

| Tool | Inputs | Use it to |
| --- | --- | --- |
| `whoami` | none | See the user, organization and team |
| `list_projects` | none | List the team's projects (one project = one app) |
| `get_project` | `project` | See the manifest, latest release and web address |
| `create_project` | `name` | Create a project (returns the existing one if the name is taken) |
| `create_upload` | `project`, `sizeBytes` | Get a one-hour upload `url` and an `uploadId` |
| `deploy` | `project`, `environment?`, `uploadId`, `manifest` | Start a release |
| `get_release` | `releaseId` | Check status: queued, building, deploying, live or failed |
| `get_logs` | `project`, `environment?`, `component`, `lines?` | Read recent log lines (max 1000) |
| `run_job` | `project`, `environment?`, `job` | Run a job now |
| `set_secret` | `project`, `environment?`, `name`, `value` | Save a secret (used on the next deploy) |
| `list_secret_names` | `project`, `environment?` | List secret names, never values |
| `remove_secret` | `project`, `environment?`, `name`, `confirm?` | Remove a secret |
| `list_templates` | none | List the team's templates |
| `list_template_versions` | `template` | List a template's versions |

`environment` defaults to the tenant default (e.g. `development`).

## Deploy the current repo

1. Read `smallfield.json` at the repo root. It is the `manifest`; its `project` is the project
   name. If it is missing, ask the user before writing one.
2. `create_project` with that name (safe if it already exists).
3. Run `git status --porcelain`. If it prints anything, tell the user that uncommitted changes
   won't be deployed and ask them to commit first.
4. Zip the repo without `node_modules`, `.git`, build output or `.env` files, e.g.
   `git archive --format=zip -o /tmp/app.zip HEAD`. Get its size in bytes.
5. `create_upload` with `project` and `sizeBytes`.
6. Upload the zip:
   `curl -fsS -X PUT -H 'content-type: application/zip' --data-binary @/tmp/app.zip "<url>"`.
7. `deploy` with `project`, `uploadId` and the `manifest` object.
8. Poll `get_release` with the returned release id every 10 seconds until `live` or `failed`.
   On `live`, show the web address. On `failed`, show the error and check `get_logs`.

Never print secret values. Ask before `remove_secret` with `confirm: true`; it restarts forks.
