# ticket-driven — チケット駆動開発 AI エージェント

Redmine チケットを起点に開発を駆動する AI エージェント用スキル群。

## セットアップ

### 1. 依存関係

```bash
npm install
```

### 2. OpenCode 設定

```bash
cp .opencode/opencode.jsonc.example .opencode/opencode.jsonc
```

`.opencode/opencode.jsonc` は gitignore 済み。以下を自分の環境に合わせて編集する。

| 項目 | 説明 |
|------|------|
| `REDMINE_URL` / `REDMINE_API_KEY` | ローカル Redmine |
| `X-API-KEY`（telospvl） | TelosPVL API キー |
| `instructions` / `mempalace` のパス | マシン固有パス（example のプレースホルダを置換） |

### 3. 環境変数（CLI 用）

```bash
export REDMINE_URL=http://127.0.0.1:3000
export REDMINE_API_KEY=your_key
./tools/redmine_helper.sh get 2
```

### 4. Cursor

- プロジェクト: `.cursor/skills/` → `skills/` へのシンボリックリンク（リポジトリ同梱）
- 個人: `~/.cursor/skills/` に同名リンクを張ると他ワークスペースでも利用可
- MCP: `.cursor/mcp.json`（Redmine / MemPalace / TelosPVL）
  - `cp .env.example .env` してキーを埋める（`.env` は gitignore）
  - 反映には Cursor のウィンドウ再読み込みが必要

### 5. 検証

```bash
npm run validate:opencode
```

## スキル一覧

正本はすべて `skills/<name>/SKILL.md`。マッピングは `skills/navigation-protocol.md`。

### チケット管理

| スキル | 内容 |
|--------|------|
| `ticket-driven` | チケット駆動開発の全体ワークフロー |
| `ticket-create` | チケット作成 |
| `ticket-list` | チケット一覧取得 |
| `ticket-refine` | チケット精緻化 |
| `ticket-relation` | チケット関連付け |
| `ticket-split` | チケット分割 |
| `ticket-status` | ステータス別アクション |
| `ticket-update` | チケット更新 |

### Git 操作

| スキル | 内容 | 使い分け |
|--------|------|----------|
| `git-commit` | コミット手順（メッセージ型・hooks） | ユーザーが明示的にコミット依頼したとき。Cursor 標準の commit ルールと併用 |
| `git-pr` | PR作成（gh / GitBucket API） | GitBucket 向け curl 手順が必要なとき。GitHub なら `gh` 標準ルールでも可 |
| `git-branch` | ブランチ操作 | ブランチ命名・切替のプロジェクト規約 |
| `git-rebase` | リベース | 衝突解決の手順確認 |
| `git-diff` | diff 確認・レビュー | レビュー観点の補助 |
| `git-log` | ログ検索 | 履歴調査 |

Cursor ユーザールールの commit/PR 手順が既定。本リポの `git-*` スキルは **GitBucket 固有・プロジェクト規約・レビュー観点** の補完として使う。

## 環境

- **GitBucket**: `http://{gitbucket-host}:8080`
- **Redmine**: `http://127.0.0.1:3000`

## ファイル構成

```
skills/<name>/SKILL.md   # 正本スキル
skills/navigation-protocol.md
.cursor/skills/          # Cursor 向けシンボリックリンク
.cursor/mcp.json         # Cursor MCP（秘密は .env）
.env.example
.opencode/
  opencode.jsonc.example # 追跡するテンプレート
  opencode.jsonc         # ローカル秘密設定（gitignore）
tools/
  redmine_helper.sh      # MCP 非接続時の Redmine CLI
  validate-opencode.mjs  # JSONC 構文検証
AGENTS.md
README.md
```
