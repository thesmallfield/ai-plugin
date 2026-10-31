---
name: docs
description: Answer questions about Small Field from its developer docs. Use when the user asks how something works on Small Field (deploys, smallfield.json, secrets, databases, Valkey (Redis), files, email, jobs, access, sign-in, connected apps, maintenance, rollback, the CLI, examples) and the answer is not already clear.
---

# Answer questions from the Small Field docs

The docs live in the user's own Console and need sign-in, so read them through the MCP tools.
Answer from the page, not from memory: the page is always newer than this skill.

## Steps

1. `list_docs` to get each page's `slug`, `title` and `summary`.
2. Pick the one or two pages that match the question.
3. `read_doc` with that `slug`.
4. Answer in a few lines with a small example, and name the page you used.
5. If the tools are missing or return 401, ask the user to sign in to the Small Field connector
   (in Claude Code: `/mcp`, pick small-field, **Authenticate**).

## Example

User: "How do I make /health work without sign-in?" Call `list_docs`, see the `access` page,
`read_doc` with slug `access`, and answer with the snippet that page shows, naming "Access & sign-in".
