---
name: connected-apps
description: Let one Small Field app call another app's API or job (exports and uses). Use when the user wants app A to read data from app B, trigger another app's job, share an API between apps, or sees an error like "<app> has not shared <scope> with <app>".
---

# Connected apps

Nothing is shared by default. The provider offers it (`exports`), the caller asks for it
(`uses`), and the provider's admins allow it in the console. Before writing config, call
`read_doc` with slug `connected-apps` for the exact fields and SDK calls.

## Steps

1. In the provider's `smallfield.json`, add an export: either `paths` (a method and a path, `*`
   at the end) or a `job`. Set `user` to `required` (default), `optional` or `none`.
2. In the caller's `smallfield.json`, add `"uses": ["<provider>:<export>"]`.
3. Deploy both.
4. Ask the user to have the provider's admins open the provider in the console, tab
   **Shared with other apps**, and tick the caller. You cannot do this step with the tools.
5. Call it with the Small Field SDK and always pass `scope` (the export name).
6. Both apps must be in the same organization and environment.

## Example

In `rooms` (the provider):

```json
"exports": { "orders.read": { "paths": ["GET /api/orders", "GET /api/orders/*"] } }
```

In `helloworld` (the caller):

```json
"uses": ["rooms:orders.read"]
```

In helloworld's server, as the signed-in person:

```ts
await sf.as(req).apps('rooms', { scope: 'orders.read' }).fetch('/api/orders');
```
