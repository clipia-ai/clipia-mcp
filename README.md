<!-- TODO founder: подтвердить имя репо/org перед публикацией (предполагается clipia-ai/clipia-mcp) -->

# Clipia MCP

**Generate AI images & video inside Claude, Cursor, ChatGPT — 20+ models in one MCP endpoint.**

[![npm clipia-ai](https://img.shields.io/npm/v/clipia-ai?label=npm%20clipia-ai&logo=npm)](https://www.npmjs.com/package/clipia-ai)
[![PyPI clipia](https://img.shields.io/pypi/v/clipia?label=PyPI%20clipia&logo=pypi&logoColor=white)](https://pypi.org/project/clipia/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![MCP](https://img.shields.io/badge/Model%20Context%20Protocol-Streamable%20HTTP-7c5cff)](https://modelcontextprotocol.io)

Clipia is an AI image & video generation platform. This is its hosted, remote **Model Context Protocol (MCP)** server: a single endpoint that lets any MCP-capable AI agent generate images and video, poll results, browse models, search prompt templates and read your credit balance — no SDK and no code required.

**Endpoint:** `https://mcp.clipia.ai/mcp` — stateless **Streamable HTTP**, authenticated with a Clipia API key.

---

## Quick start

Connect Clipia to Claude Code in one command (replace the placeholder with your key):

```bash
claude mcp add --transport http clipia https://mcp.clipia.ai/mcp \
  --header "Authorization: Bearer clipia_live_YOUR_KEY"
```

Then just ask in the chat: *"Generate a neon city image with Clipia"* — the preview lands right in the terminal.

**Where to get a key:** create one at [clipia.ai/settings](https://clipia.ai/settings) → the **API keys** tab. The key is shown once.

**Sandbox without charges:** keys with the `clipia_test_` prefix run in a sandbox — instant mock results, no credits spent. Use a `clipia_test_*` key to validate your integration before going live.

---

## Connect from any client

The endpoint is the same everywhere: `https://mcp.clipia.ai/mcp`. IDEs and CLIs authenticate with an API key from settings; **claude.ai** and **ChatGPT** connect by signing in to your Clipia account over OAuth (no key needed).

Ready-to-paste configs live in [`examples/`](./examples).

| Client | How to connect | Auth |
| --- | --- | --- |
| **Claude Code** | `claude mcp add --transport http clipia …` (see Quick start) | API key |
| **Claude Desktop** | `mcp-remote` bridge in `claude_desktop_config.json` | API key |
| **claude.ai** (web/desktop/mobile) | Settings → Connectors → Add custom connector | OAuth |
| **Cursor** | `~/.cursor/mcp.json` (or project `.cursor/mcp.json`) | API key |
| **VS Code** | `.vscode/mcp.json` (`servers` + `inputs`) | API key |
| **Cline** | `cline_mcp_settings.json` (`mcpServers`) | API key |
| **Windsurf** | `~/.codeium/windsurf/mcp_config.json` (`serverUrl`) | API key |
| **Codex CLI** | `~/.codex/config.toml` (`bearer_token_env_var`) | API key (env) |
| **Gemini CLI** | `gemini mcp add --transport http clipia …` | API key |
| **ChatGPT** | Developer mode → Apps & Connectors → Create | OAuth |

### Claude Code

```bash
claude mcp add --transport http clipia https://mcp.clipia.ai/mcp \
  --header "Authorization: Bearer clipia_live_YOUR_KEY"
```

### Claude Desktop

Claude Desktop bridges to remote HTTP servers through [`mcp-remote`](https://www.npmjs.com/package/mcp-remote). Add to `claude_desktop_config.json` (Settings → Developer → Edit Config), then restart Claude Desktop:

```json
{
  "mcpServers": {
    "clipia": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://mcp.clipia.ai/mcp",
        "--header",
        "Authorization: Bearer clipia_live_YOUR_KEY"
      ]
    }
  }
}
```

### claude.ai (web / desktop / mobile)

1. Open **Settings → Connectors**.
2. Click **Add custom connector** and paste the URL: `https://mcp.clipia.ai/mcp`
3. Click **Connect** and sign in to your Clipia account — no key needed (OAuth).
4. In a new chat, ask for an image or a video: a live Clipia card with progress and the result appears inside the message.

> Credits are charged to the connected Clipia account.

### Cursor

Add to `~/.cursor/mcp.json` (global) or `.cursor/mcp.json` (project), then restart Cursor:

```json
{
  "mcpServers": {
    "clipia": {
      "url": "https://mcp.clipia.ai/mcp",
      "headers": { "Authorization": "Bearer clipia_live_YOUR_KEY" }
    }
  }
}
```

### VS Code

Create `.vscode/mcp.json` in your workspace (or use the **MCP: Add Server** command). VS Code prompts for the key on first run and stores it securely:

```json
{
  "servers": {
    "clipia": {
      "type": "http",
      "url": "https://mcp.clipia.ai/mcp",
      "headers": { "Authorization": "Bearer ${input:clipia_api_key}" }
    }
  },
  "inputs": [
    {
      "type": "promptString",
      "id": "clipia_api_key",
      "description": "Clipia API Key",
      "password": true
    }
  ]
}
```

### Cline

Cline reads `mcpServers` from its `cline_mcp_settings.json` (MCP Servers → Configure MCP Servers in the Cline panel):

```json
{
  "mcpServers": {
    "clipia": {
      "url": "https://mcp.clipia.ai/mcp",
      "headers": { "Authorization": "Bearer clipia_live_YOUR_KEY" }
    }
  }
}
```

Cline can also install this server itself — see [`llms-install.md`](./llms-install.md).

### Windsurf

Add to `~/.codeium/windsurf/mcp_config.json` (note the Windsurf-specific `serverUrl` field), then refresh **Cascade → MCPs**:

```json
{
  "mcpServers": {
    "clipia": {
      "serverUrl": "https://mcp.clipia.ai/mcp",
      "headers": { "Authorization": "Bearer clipia_live_YOUR_KEY" }
    }
  }
}
```

### Codex CLI

Add a block to `~/.codex/config.toml` and export the key into your environment — Codex injects `Authorization: Bearer` from the variable automatically:

```toml
# ~/.codex/config.toml
[mcp_servers.clipia]
url = "https://mcp.clipia.ai/mcp"
bearer_token_env_var = "CLIPIA_API_KEY"

# in your environment:
# export CLIPIA_API_KEY="clipia_live_YOUR_KEY"
```

### Gemini CLI

```bash
gemini mcp add --transport http clipia https://mcp.clipia.ai/mcp \
  --header "Authorization: Bearer clipia_live_YOUR_KEY"
```

Verify the connection with `gemini mcp list`.

### ChatGPT (Developer Mode)

1. In ChatGPT (web): **Settings → Apps & Connectors → Advanced settings** → enable **Developer mode** (Plus, Pro, Business, Enterprise).
2. Back in **Apps & Connectors → Create**. Name it `Clipia`, MCP Server URL: `https://mcp.clipia.ai/mcp`.
3. Authentication — **OAuth**, tick "I trust this application", click **Create**.
4. Sign in to your Clipia account in the popup. In a chat press **+ → More → Clipia**, then ask in plain text.

**Supported auth header schemes:** `Authorization: Bearer clipia_*` (recommended), `Authorization: Key <key>`, or `X-Api-Key: <key>`.

---

## Tools

The server exposes **8 tools to the agent** (plus one app-only helper). Compact schemas keep the agent's context window light.

| Tool | What it does |
| --- | --- |
| `generate_image` | Generate image(s) from a text prompt, optionally with reference images (editing / image-to-image). Waits briefly and usually returns the finished image inline (URL + small preview). Cost in credits is returned. |
| `generate_video` | Start a video generation from a text prompt (text-to-video) or from a start image (image-to-video, pass `image_url`). Returns `request_id` and cost in credits immediately — renders take 1–10 min, poll with `wait_generation`. |
| `wait_generation` | Wait for a generation to finish (long-poll up to `wait_seconds`, then returns current status). Call repeatedly until `COMPLETED`, `FAILED` or `CANCELED`. Returns output URLs (and an inline preview) when done. |
| `get_generation` | Get the current status/result of a generation without waiting. When `COMPLETED`, `output.images[].url` is the inline webp preview and `output.images[].original_url` is the full-quality PNG/JPG. |
| `list_models` | List available AI models with type (image/video/audio), capabilities and base price in credits. Filter by `type` / `search`. |
| `get_model` | Get model details: supported input parameters (`input_schema`) and base price in credits. |
| `get_balance` | Get the credit balance of the connected Clipia account and 30-day usage of the current API key. |
| `search_templates` | Search 3500+ curated prompt templates (hybrid text+semantic search, Russian or English query). Each result has a ready-to-use prompt and a recommended model. |
| `app_get_generation` | *Internal / app-only:* status poll used by the Clipia generation viewer card (MCP Apps). Hidden from the model; prefer `get_generation`. |

**Default models** (used when no slug is passed): `nano-banana-2` for images, `seedance-2-fast-t2v` / `seedance-2-fast-i2v` for video. Override with a model slug from `list_models`.

---

## Why Clipia

- **Pay from Russia & CIS** — Russian bank cards, SBP, MIR, no VPN required. Western processors reject these; Clipia is built for this market (and works internationally too).
- **20+ flagship models, one endpoint** — Western and Chinese models side by side: Veo 3.1, Sora, Kling 3, Seedance 2, Hailuo, Wan 2.7, Nano Banana, FLUX, Midjourney V7, Imagen 4, and more. No juggling multiple foreign subscriptions.
- **Sandbox without charges** — `clipia_test_*` keys return instant mock results with no credit spend, perfect for wiring up an integration or CI.
- **Live preview in the chat (MCP Apps)** — on claude.ai (web/desktop/mobile) every generation renders an interactive card with live progress, the finished media and an "Original" button. In Claude Code the preview lands inline in the terminal for vision-based iteration.
- **3500+ prompt templates** — `search_templates` gives the agent curated, ready-to-use prompts (hybrid search, RU/EN), each with a recommended model.
- **Cost in every response** — every generation returns its exact cost in credits, and `get_balance` shows the remaining balance. No hidden MCP markup.
- **Compact tool surface** — 8 tools with tight schemas keep the agent's context window light (versus 30+ tools that can eat ~12K tokens elsewhere).

---

## SDK

Prefer calling Clipia from your own code instead of an agent? Use the official SDKs against the same public API (fal.ai-style `submit → status → result` queue, credits-based billing):

- **TypeScript / Node:** [`clipia-ai`](https://www.npmjs.com/package/clipia-ai) — `npm install clipia-ai` (also ships a `clipia` CLI).
- **Python:** [`clipia`](https://pypi.org/project/clipia/) — `pip install clipia` (sync + async clients).

Both support webhooks with HMAC-SHA256 signature verification and the same `clipia_test_*` sandbox keys.

---

## Pricing

Billing is in **credits** from your connected Clipia account — the same balance as the website. Every generation returns its exact credit cost, and `get_balance` shows what's left. Different models cost different credits depending on resolution, duration and quality.

New accounts receive a small pack of **welcome credits** to evaluate the platform; after that a subscription is required. Four monthly plans (Basic / Standard / Pro / Ultima) — see [clipia.ai/tariffs](https://clipia.ai/tariffs).

`clipia_test_*` sandbox keys return mock results with **no credit charge** — use them to develop and test without spending.

---

## 🇷🇺 Для России и СНГ

Clipia — российская платформа AI-генерации изображений и видео. Главное отличие от западных сервисов: **оплата картой РФ, СБП и МИР, без VPN**. 20+ топовых западных и китайских моделей (Veo 3.1, Sora, Kling 3, Seedance 2, Nano Banana, FLUX, Midjourney V7) в одном MCP-эндпоинте, прямо из Claude, Cursor, ChatGPT.

Подключение в одну команду (ключ — в [Настройках → API-ключи](https://clipia.ai/settings)):

```bash
claude mcp add --transport http clipia https://mcp.clipia.ai/mcp \
  --header "Authorization: Bearer clipia_live_ВАШ_КЛЮЧ"
```

Ключи `clipia_test_*` — песочница без списания кредитов для отладки. Биллинг в кредитах, стоимость каждой генерации возвращается в ответе. Тарифы: [clipia.ai/tariffs](https://clipia.ai/tariffs).

---

## Links

- **Developers / REST API & SDK:** [clipia.ai/developers](https://clipia.ai/developers)
- **MCP landing:** [clipia.ai/mcp](https://clipia.ai/mcp)
- **Model catalog:** [clipia.ai/models](https://clipia.ai/models)
- **Pricing:** [clipia.ai/tariffs](https://clipia.ai/tariffs)
- **Get an API key:** [clipia.ai/settings](https://clipia.ai/settings)

---

## License

MIT — see [LICENSE](./LICENSE). © 2026 Clipia (IP Zakharov Maksim Sergeevich).
