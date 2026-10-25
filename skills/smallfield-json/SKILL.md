---
name: smallfield-json
description: Write or fix smallfield.json, the Small Field manifest at the repo root. Use when the user wants to set up a repo for Small Field, add a component (static site, web server, job), change paths or ports, add secrets, a database, a scheduled job, let one app call another (exports and uses), or when a deploy fails with a "smallfield.json (at ...)" error.
---

# Write or fix smallfield.json

`smallfield.json` sits at the repo root and says what the app is made of. Every field and rule is
in the docs. For each part below, call `read_doc` with the slug it names **before** writing, and
follow that page. If `read_doc` fails, ask the user to sign in to the connector; do not guess.

## Start or fix the file

1. `read_doc` `smallfield-json`, and `components` when there is more than one part.
2. Read the repo: which folders are a website, a server or a script, and their package files.
3. Write one component per part, as the page shows. Keep only what the app needs.
4. A deploy error like `smallfield.json (at "components.api.path")` names the field. Read that
   field on the page, fix it, and deploy again.

## Jobs

1. `read_doc` `jobs`.
2. Add the job component the page describes, with a schedule only if the user wants one.
3. After the deploy, start it with `run_job` to check it works.

## Secrets

1. `read_doc` `secrets`.
2. Put only the **names** in the file. Never write a value into the file, the code or the chat log.
3. Ask the user for each value and save it with `set_secret` (see the `deploy` skill).

## Databases

1. `read_doc` `databases`.
2. Add the database entry and, if the app changes its schema, the migrate command, as the page shows.

## One app calls another

1. `read_doc` `connected-apps`.
2. Add `exports` in the provider and `uses` in the caller, as the page shows. Deploy both.
3. Tell the user the step only a person can do in the console (the page names it).

## Example

User: "Add a nightly cleanup script." `read_doc` `jobs`, add a `cleanup` job with a daily
schedule as the page shows, deploy, then `run_job` with `job: "cleanup"` and report the result.
