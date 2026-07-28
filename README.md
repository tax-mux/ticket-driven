# ticket-driven — チケット駆動開発 AI エージェント

Redmine チケットを起点に開発を駆動する AI エージェント用スキル群。

## スキル一覧

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

| スキル | 内容 |
|--------|------|
| `git-commit` | Gitコミット |
| `git-pr` | PR作成 |
| `git-branch` | ブランチ操作 |
| `git-rebase` | リベース操作 |
| `git-diff` | diff確認・レビュー |
| `git-log` | ログ検索 |

## 環境

- **GitBucket**: `http://{gitbucket-host}:8080`
- **Redmine**: `http://127.0.0.1:3000`

## ファイル構成

```
skills/
  ticket-driven/       # メインスキル
  ticket-create/
  ticket-list/
  ticket-refine/
  ticket-relation/
  ticket-split/
  ticket-status/
  ticket-update/
  git-commit/
  git-pr/
  git-branch/
  git-rebase/
  git-diff/
  git-log/
AGENTS.md              # プロジェクト固有ルール
README.md
```
