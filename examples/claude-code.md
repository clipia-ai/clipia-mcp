# Claude Code — connect Clipia MCP

One command in your terminal. Replace `clipia_live_YOUR_KEY` with a key from
[clipia.ai/settings](https://clipia.ai/settings) → **API keys**.

```bash
claude mcp add --transport http clipia https://mcp.clipia.ai/mcp \
  --header "Authorization: Bearer clipia_live_YOUR_KEY"
```

Then ask Claude: *"Generate a neon city image with Clipia"* — the preview lands
right in the terminal.

To test without spending credits, use a sandbox key (`clipia_test_YOUR_KEY`):
instant mock results, no charge.

Remove the server later with:

```bash
claude mcp remove clipia
```
