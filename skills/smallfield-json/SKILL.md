---
name: smallfield-json
description: Write or fix smallfield.json, the Small Field manifest at the repo root. Use when the user wants to set up a repo for Small Field, add a component (static site, web server, job), change paths or ports, pick a runtime or machine size, or when a deploy fails with a "smallfield.json (at ...)" error.
---

# Write or fix smallfield.json

`smallfield.json` sits at the repo root and says what the app is made of. Before writing config,
call `read_doc` with slug `smallfield-json` for the exact fields and rules (and `components` for
routing).

## Steps

1. Read the repo: which folders are a website, a server or a script, and their package files.
2. Pick a `project` name: lowercase letters, digits and hyphens, up to 40 characters, not ending
   in `-dev`, `-staging` or `-production`.
3. Add one component per part, each with a `kind` and a `dir`:
   - `static`: a built website. Add `build` and `output` (default `dist`).
   - `web`: a server. It must listen on `process.env.PORT` and `0.0.0.0`. `port` defaults to 8080.
   - `job`: a script that runs to the end. Needs `command`; `schedule` is optional.
4. Set `path` when there is more than one component: `static` at `/`, `web` at `/<name>`. The
   prefix is removed before the request reaches the code unless `"stripPrefix": false`.
5. Add `databases`, `secrets` (names only, never values), `public` paths or `exports`/`uses`
   only when the app needs them.
6. Unknown keys are ignored, so check spelling. When a deploy fails, the error names the field,
   e.g. `smallfield.json (at "components.api.path")`. Fix that field and deploy again.

## Example

```json
{
  "project": "notes",
  "components": {
    "ui": { "kind": "static", "dir": "ui", "path": "/", "build": "npm run build" },
    "api": { "kind": "web", "dir": "api", "path": "/api", "port": 8080 }
  },
  "databases": [{ "engine": "postgres" }]
}
```

The UI calls `fetch('/api/notes')`; the API code handles `/notes`.
