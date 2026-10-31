---
name: troubleshoot
description: Find out why a Small Field app is broken and fix it. Use when a deploy or release failed, the app shows errors or does not load, the user wants logs or the app's status, or needs to put the app in maintenance or roll back.
---

# Troubleshoot a Small Field app

`read_doc` `logs-and-releases` first; it explains releases, logs and rollback. Use `maintenance`
for the maintenance page and `limits` when something looks capped.

## Steps

1. `get_project` with the project: the latest release, its status and the web address.
2. If the release `failed`, `get_release` with its id shows the error. A `smallfield.json (at ...)`
   error names the field: fix it with the `smallfield-json` skill.
3. `get_logs` with `project` and `component` shows what the app printed.
4. Match the error to a doc page and read it before changing code. Usual causes:
   - The server does not listen where Small Field expects: `read_doc` `smallfield-json`.
   - Routes get the wrong URL: `read_doc` `components`.
   - A missing secret (`list_secret_names`) or env var: `read_doc` `secrets`.
   - A failing migration or database error: `read_doc` `databases`, and `query_database` to look
     at the data (read-only).
   - `NOPERM No permissions to access a key`, `OOM`, or `"engine": "redis"` refused: `read_doc`
     `valkey`. NOPERM means a key or channel without the `VALKEY_PREFIX`. We offer Valkey, a
     drop-in replacement for Redis; never suggest running Redis yourself.
5. If the live app is broken and the fix will take time, offer `rollback` (back to the release
   before), then poll `get_release`.
6. While fixing, offer `set_maintenance` with `on: true` and a short `message`; turn it off after.
7. Before a risky database fix, offer `backup_database`; `list_database_backups` shows the files.

## Example

User: "My app shows 502." `get_project`, then `get_logs` for the `web` component. The log says
`listening on 127.0.0.1:3000`. `read_doc` `smallfield-json`, change the server as the page says,
deploy with the `deploy` skill, and poll `get_release` until `live`.
