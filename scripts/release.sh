#!/usr/bin/env bash
# Builds the Claude and ChatGPT plugin zips into dist/, with the MCP URL from SAAS_MCP_URL.
set -euo pipefail

cd "$(dirname "$0")/.."
url="${SAAS_MCP_URL:-https://console.example.com/mcp}"
out="$PWD/dist"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
rm -rf "$out" && mkdir -p "$out"

claude="$work/claude/small-field"
mkdir -p "$claude/.claude-plugin"
cp -r skills README.md LICENSE "$claude/"
jq 'del(.userConfig)' .claude-plugin/plugin.json > "$claude/.claude-plugin/plugin.json"
jq -n --arg url "$url" '{ mcpServers: { "small-field": { type: "http", url: $url } } }' \
    > "$claude/.mcp.json"
(cd "$work/claude" && zip -qr "$out/small-field-claude-plugin.zip" small-field)

chatgpt="$work/chatgpt/small-field"
mkdir -p "$chatgpt"
cp -r skills README.md LICENSE "$chatgpt/"
jq '{
    "$schema": "https://agent-plugins.org/schemas/1.0.0/plugin.schema.json",
    name, version, author, repository, license, keywords,
    description: "Deploy and manage your Small Field apps with ChatGPT.",
    extensions: { "com.openai": { interface: { displayName } } }
}' .claude-plugin/plugin.json > "$chatgpt/plugin.json"
jq -n --arg url "$url" '{
    "$schema": "https://agent-plugins.org/schemas/1.0.0/mcp.schema.json",
    mcpServers: { "small-field": {
        type: "streamable-http",
        url: $url,
        extensions: { "com.openai": { auth: { type: "oauth", client: { mode: "dcr" } } } }
    } }
}' > "$chatgpt/mcp.json"
(cd "$work/chatgpt" && zip -qr "$out/small-field-chatgpt-plugin.zip" small-field)

ls -l "$out"
