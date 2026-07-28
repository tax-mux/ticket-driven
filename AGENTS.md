# AGENTS.md — ticket-driven

## Redmine プロジェクト

| 項目 | 値 |
|------|-----|
| プロジェクト識別子 | `{your-redmine-project}` |
| プロジェクト名 | macbook pro 作業環境 |
| APIキー | 環境変数 `REDMINE_API_KEY` に設定 |
| URL | `http://127.0.0.1:3000` |

## GitBucket

| 項目 | 値 |
|------|-----|
| URL | `http://{gitbucket-host}:8080` |
| リポジトリ | `ticket-driven` |

## スキル配置

| 場所 | 用途 |
|------|------|
| `skills/<name>/SKILL.md` | 正本（OpenCode / Cursor 共通） |
| `.cursor/skills/<name>` | Cursor プロジェクトスキル（正本への symlink） |
| `~/.cursor/skills/<name>` | 個人グローバル（任意・正本への symlink） |
| `.opencode/opencode.jsonc` | OpenCode 登録（gitignore。example からコピー） |

マッピング: `skills/navigation-protocol.md`

## スキル一覧

| スキル名 | 内容 |
|---------|------|
| `ticket-driven` | チケット駆動開発の全体ワークフロー |
| `ticket-create` | チケット作成 |
| `ticket-list` | チケット一覧取得 |
| `ticket-refine` | チケット精緻化 |
| `ticket-relation` | チケット関連付け |
| `ticket-split` | チケット分割 |
| `ticket-status` | ステータス別アクション |
| `ticket-update` | チケット更新 |
| `git-commit` | Gitコミット（依頼時。標準ルールと併用） |
| `git-pr` | PR作成（gh / GitBucket API） |
| `git-branch` | ブランチ操作 |
| `git-rebase` | リベース操作 |
| `git-diff` | diff確認・レビュー |
| `git-log` | ログ検索 |

### Git スキルと Cursor 標準ルール

- コミット・PR の安全手順は Cursor ユーザールールが既定。
- `git-*` スキルは GitBucket API・本リポの命名/レビュー観点の補完。矛盾時はユーザー明示指示を優先。

## チケット

| ID | 題名 | 種別 | 状態 | 優先度 | 作成日 |
|----|------|------|------|--------|--------|
| 2 | チケット駆動開発用AIエージェントスキル作成 | 機能 | 解決 | 通常 | 2026-07-28 |

## ワークフロー

### 着手前チェックリスト

1. リモートリポジトリが確保されているか確認（`git remote -v`）
   - 未確保の場合: チケットに「リポジトリ未作成」を登録し、保留にする
2. チケットの内容を確認
3. 説明が不足している場合は `ticket-refine` で精緻化
4. 範囲が広い場合は `ticket-split` で分割

### 実装中

5. 実装中は随時 `ticket-driven` のジャーナル記録テンプレートで更新
6. 開発タスクは必ずRedmineチケットで管理
7. 進捗は随時Redmineジャーナルに記録

### 完了時

8. **説明には必ずリモートリポジトリURLを記述**
9. **作業区切りごとにジャーナルにコメント**
10. **完了前に説明を更新（完了条件・テスト範囲）**
11. **説明が更新されてから解決**
12. **作業完了後、必ずコミットしてPRを作成**
