# Installing Clipia MCP (instructions for an AI agent)

You are an AI agent (Cline or similar) installing the **Clipia MCP server** for the user. Clipia generates AI images and video. Follow these steps exactly.

## 1. What you are connecting

- **Server name:** `clipia`
- **Transport:** Streamable HTTP (remote, hosted — there is nothing to clone, build or run locally)
- **Endpoint URL:** `https://mcp.clipia.ai/mcp`
- **Auth:** an API key sent as `Authorization: Bearer <key>`

## 2. Get the API key

Ask the user for their Clipia API key. If they don't have one, tell them to create it in the Developer Console at **https://clipia.ai/en/developer** (the key is shown only once).

- Live keys start with `clipia_live_` (charges credits).
- Sandbox keys start with `clipia_test_` (instant mock results, **no credit charge**) — recommended for first-time testing.

Do **not** invent or hard-code a key. Use the exact key the user provides.

## 3. Add the server to the MCP settings

Add this entry to the user's MCP settings file (for Cline: `cline_mcp_settings.json`). Merge it into the existing `mcpServers` object — do not overwrite other servers. Replace `clipia_test_YOUR_KEY` with the user's actual key.

```json
{
  "mcpServers": {
    "clipia": {
      "url": "https://mcp.clipia.ai/mcp",
      "headers": {
        "Authorization": "Bearer ${CLIPIA_API_KEY}"
      }
    }
  }
}
```

If the host requires an explicit transport type, set `"type": "http"`. The host expects a remote HTTP server — no `command`/`args`, no local process.

## 4. Verify the connection

After saving the settings, confirm the server is reachable:

1. Reload / refresh the MCP server list so the host re-reads the config.
2. Call the `list_models` tool (no arguments needed). A successful response returns available text, image, video and audio models with their credit prices — this proves auth works. Use `type: "text"` to discover slugs accepted by `chat`.
3. Optionally call `get_balance` to confirm the connected account and remaining credits.

## 5. Smoke-test a generation (sandbox)

If the user supplied a `clipia_test_*` key, run a no-cost test:

- Call `generate_image` with `{ "prompt": "a red panda coding at night" }`.
- The sandbox returns an instant mock `COMPLETED` result with no credit charge.

For a live key, the same call performs a real generation and the response includes the exact cost in credits.

## 6. Available tools (for reference)

The 10 core tools are `generate_image`, `generate_video`, `generate_audio`, `generate_music`, `wait_generation`, `get_generation`, `list_models`, `get_model`, `get_balance` and `search_templates`. Production currently also exposes `generate_scenario`, `compose_video` and `generate_presentation`; clients should use `tools/list` because these additional capabilities are feature-gated.

Typical flow: `generate_image` / `generate_video` → if the result is non-terminal (`IN_QUEUE` / `IN_PROGRESS`), poll with `wait_generation` using the returned `request_id` until `COMPLETED`. Video takes 1–10 minutes. Never tell the user the result is ready before a tool returns `COMPLETED` with an output URL.

## 7. Done

Report success to the user, mention they can manage or revoke the key at https://clipia.ai/en/developer, and that billing is in credits (see https://clipia.ai/en/tariffs).
