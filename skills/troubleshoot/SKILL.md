---
name: troubleshoot
description: Find out why a Small Field app is broken and fix it. Use when a deploy or release failed, the app shows errors or does not load, the user wants logs or the app's status, or needs to put the app in maintenance or roll back.
---

# Troubleshoot a Small Field app

Before changing anything, call `read_doc` with slug `logs-and-releases` (and `maintenance` for
maintenance mode) for the exact behaviour.

## Steps

1. `get_project` with the project: see the latest release, its status and the web address.
2. If the release `failed`, `get_release` with its id shows the error. A `smallfield.json (at ...)`
   error names the field to fix.
3. `get_logs` with `project` and `component` (up to 1000 `lines`) shows what the app printed.
4. Check the usual causes:
   - The server does not listen on `process.env.PORT` and `0.0.0.0`.
   - A missing secret (`list_secret_names`) or a failing `migrate` command.
   - A wrong `path` or `stripPrefix`, so routes get the wrong URL.
   - Rising restarts usually mean a crash or out of memory; try a bigger `size`.
5. While fixing, `set_maintenance` with `on: true` and a short `message` shows visitors a
   maintenance page. Owners and admins still get through. Turn it off with `on: false`.
6. To roll back, check out the earlier commit and deploy again. There is no rollback button.
7. A failed release does not take the app down: the old one keeps serving.

## Example

User: "My app shows 502." Call `get_project`, then `get_logs` for the `web` component. The log
says `listening on 127.0.0.1:3000`; change the server to listen on `0.0.0.0` and `PORT`, deploy,
and poll `get_release` until `live`.
