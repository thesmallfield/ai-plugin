---
name: secrets-and-databases
description: Add secrets, environment variables or a Postgres database to a Small Field app. Use when the user needs an API key or password in their app, asks how to read env vars on Small Field, wants a database, DATABASE_URL, or migrations.
---

# Secrets and databases

Before writing config, call `read_doc` with slug `secrets` or `databases` for the exact fields
and the variables Small Field sets for you.

## Secrets

1. List the names the app needs in `smallfield.json`, e.g. `"secrets": { "STRIPE_KEY": "env" }`.
   Never put values in the file or in code.
2. Ask the user for the value, then `set_secret` with `project`, `name` and `value`. Never print
   or log it. Add `environment` for anything but the default.
3. `list_secret_names` shows what is set (names only).
4. A secret reaches the app on the **next deploy**. The app reads `process.env.STRIPE_KEY`.
5. Names Small Field sets are refused: `PORT`, `SMALLFIELD_*`, `SF_FILES_URL`, `SF_AUTH_URL`.
6. A static site only gets names starting with `VITE_`, `NEXT_PUBLIC_`, `PUBLIC_` and similar.
   Those end up in the browser, so never use them for a real secret.

## Databases

1. Add `"databases": [{ "engine": "postgres" }]`. The app reads `DATABASE_URL`.
2. A second database needs a `name`: `{ "engine": "postgres", "name": "analytics" }` arrives as
   `DATABASE_URL_ANALYTICS`.
3. Each environment has its own data. Data survives redeploys.
4. For schema changes, add `"migrate": "npm run db:migrate"` to a `web` component. It runs before
   each deploy; make it safe to run twice.

## Example

```json
"secrets": { "OPENAI_API_KEY": "env" },
"databases": [{ "engine": "postgres" }]
```

Then `set_secret` `OPENAI_API_KEY` and deploy.
