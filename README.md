# ticket-driven — Ticket-driven development for AI agents

[日本語版 / Japanese](README-JP.md)

Skill pack that drives development from **Redmine** issues.

## Works best with mcp-redmine

These skills shine when [**mcp-redmine**](https://github.com/tax-mux/mcp-redmine) is installed and connected (SSE MCP for the Redmine REST API). Journaling, status / `done_ratio` updates, refine / split gates, and the everyday ticket-driven loop assume an agent can call Redmine through MCP.

Without mcp-redmine you can still use `./tools/redmine_helper.sh` as a CLI fallback, but the full agent workflow is designed for mcp-redmine.

## Setup

### 1. Dependencies

```bash
npm install
```

### 2. OpenCode config

```bash
cp .opencode/opencode.jsonc.example .opencode/opencode.jsonc
```

`.opencode/opencode.jsonc` is gitignored. Edit for your environment:

| Item | Description |
|------|-------------|
| `REDMINE_URL` / `REDMINE_API_KEY` | Local Redmine |
| `X-API-KEY` (telospvl) | TelosPVL API key |
| `instructions` / `mempalace` paths | Machine-local paths (replace example placeholders) |

### 3. Environment (CLI)

```bash
export REDMINE_URL=http://127.0.0.1:3000
export REDMINE_API_KEY=your_key
./tools/redmine_helper.sh get 2
```

### 4. Cursor

- Project: `.cursor/skills/` → symlinks into `skills/` (shipped in-repo)
- Personal: symlink the same names under `~/.cursor/skills/` for other workspaces
- MCP: `.cursor/mcp.json` (Redmine / MemPalace / TelosPVL)
  - Prefer pointing Redmine at **mcp-redmine** (URL only; keep API keys out of client config)
  - Or `cp .env.example .env` and fill keys (`.env` is gitignored)
  - Reload the Cursor window after changes

### 5. OpenCode / Hermes

Canonical skills live in `skills/`. Symlink; do not copy:

```bash
./tools/sync-skill-links.sh
```

| Runtime | Location |
|---------|----------|
| OpenCode | `~/.agents/skills/<name>` |
| Hermes | `~/.hermes/skills/software-development/<name>` |

Restart OpenCode / Hermes if needed.

Hermes `agent.system_prompt` is a snapshot. Sync current TelosPVL IDs / INIT_BOOTSTRAP with:

```bash
hermes-sync-opencode-rules
```

Restart is not automated; restart Hermes yourself.

### 6. Validate

```bash
npm run validate:opencode
```

## Skills

Canonical files are `skills/<name>/SKILL.md`. Index: `skills/navigation-protocol.md`.

### Ticket management

| Skill | Purpose |
|-------|---------|
| `ticket-driven` | End-to-end ticket-driven workflow |
| `ticket-create` | Create issues |
| `ticket-list` | List / filter issues |
| `ticket-refine` | Refine requirements before split |
| `ticket-relation` | Issue relations |
| `ticket-split` | Split by capability → session-sized children |
| `ticket-status` | Status-based actions |
| `ticket-update` | Update fields / description |

### Git

| Skill | Purpose | When |
|-------|---------|------|
| `git-commit` | Commit procedure | User explicitly asks to commit; use with Cursor commit rules |
| `git-pr` | PR creation (gh / GitBucket API) | GitBucket curl flow, or GitHub via `gh` |
| `git-branch` | Branch naming / switching | Project conventions |
| `git-rebase` | Rebase / conflicts | Conflict resolution |
| `git-diff` | Diff / review aids | Review checklists |
| `git-log` | History search | Investigation |

Cursor user rules own the default commit/PR safety steps. This repo’s `git-*` skills add GitBucket-specific and project conventions.

## Environment

- **Git host**: `http://{git-host}:{port}` or GitHub (environment-specific)
- **Redmine**: `http://127.0.0.1:3000` (or your own)

## License

[MIT](./LICENSE)

## Layout

```
skills/<name>/SKILL.md   # canonical skills
skills/navigation-protocol.md
.cursor/skills/          # Cursor symlinks
.cursor/mcp.json         # Cursor MCP (secrets in .env or mcp-redmine)
.env.example
.opencode/
  opencode.jsonc.example
  opencode.jsonc         # local secrets (gitignored)
tools/
  redmine_helper.sh      # Redmine CLI when MCP is down
  validate-opencode.mjs
AGENTS.md
README.md
README-JP.md
LICENSE
```
