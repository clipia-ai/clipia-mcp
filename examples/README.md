# Clipia MCP — connection examples

Copy-paste configs for each client. Endpoint is always
`https://mcp.clipia.ai/mcp`. Replace `clipia_live_YOUR_KEY` with a key from
[Clipia Developer Console](https://clipia.ai/en/developer)
(or a `clipia_test_*` sandbox key for no-cost testing).

| File                                                         | Client         | Where it goes                                   |
| ------------------------------------------------------------ | -------------- | ----------------------------------------------- |
| [`claude-code.md`](./claude-code.md)                         | Claude Code    | terminal command                                |
| [`claude-desktop-config.json`](./claude-desktop-config.json) | Claude Desktop | `claude_desktop_config.json` (via `mcp-remote`) |
| [`cursor-mcp.json`](./cursor-mcp.json)                       | Cursor         | `~/.cursor/mcp.json` or `.cursor/mcp.json`      |
| [`vscode-mcp.json`](./vscode-mcp.json)                       | VS Code        | `.vscode/mcp.json`                              |
| [`cline-mcp.json`](./cline-mcp.json)                         | Cline          | `cline_mcp_settings.json`                       |
| [`windsurf-mcp.json`](./windsurf-mcp.json)                   | Windsurf       | `~/.codeium/windsurf/mcp_config.json`           |

**claude.ai** and **ChatGPT** connect over OAuth (no key file) — see the main
[README](../README.md#connect-from-any-client).

## Security

These files ship with a `clipia_live_YOUR_KEY` placeholder. **Never commit a
file containing a real key.** When you fill in your own key:

- Save your edited copy as `*.local.json` (e.g. `cursor-mcp.local.json`) — the
  [`.gitignore`](../.gitignore) keeps those out of version control.
- Prefer a `clipia_test_*` sandbox key when sharing configs (no credits spent).
- The VS Code example uses `${input:clipia_api_key}` so the key is prompted at
  runtime and never stored in the file — the safest pattern.
