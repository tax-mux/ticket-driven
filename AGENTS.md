# AGENTS.md — ticket-driven

## Redmine プロジェクト

| 項目 | 値 |
|------|-----|
| プロジェクト識別子 | `{your-redmine-project}` |
| プロジェクト名 | macbook pro 作業環境 |
| APIキー | 環境変数 `REDMINE_API_KEY` に設定 |

## GitBucket

| 項目 | 値 |
|------|-----|
| URL | `http://{gitbucket-host}:8080` |
| リポジトリ | `ticket-driven` |

## スキル

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
| `git-commit` | Gitコミット |
| `git-pr` | PR作成 |
| `git-branch` | ブランチ操作 |
| `git-rebase` | リベース操作 |
| `git-diff` | diff確認・レビュー |
| `git-log` | ログ検索 |

## チケット

| ID | 題名 | 種別 | 状態 | 優先度 | 作成日 |
|----|------|------|------|--------|--------|
| 2 | チケット駆動開発用AIエージェントスキル作成 | 機能 | 新規 | 通常 | 2026-07-28 |

## ワークフロー

1. チケット着手前に `ticket-driven` スキルの「着手前チェックリスト」を確認
2. 説明が不足している場合は `ticket-refine` で精緻化
3. 範囲が広い場合は `ticket-split` で分割
4. 実装中は随時 `ticket-driven` のジャーナル記録テンプレートで更新
5. 開発タスクは必ずRedmineチケットで管理
6. 進捗は随時Redmineジャーナルに記録
