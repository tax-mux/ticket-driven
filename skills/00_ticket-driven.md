# チケット駆動開発 (Ticket-Driven Development)

Redmine チケットを起点に開発タスクを駆動する。

## スキルトリガー（navigation-protocol 登録済み）

| 生発音（ローマ字） | パス |
|---|---|
| ticketcreate | skills/ticket-create.md |
| ticketstatus | skills/ticket-status.md |
| ticketupdate | skills/ticket-update.md |
| ticketlist | skills/ticket-list.md |
| ticketrelation | skills/ticket-relation.md |

## ワークフロー

### 1. チケット取得

ユーザーがチケット番号（例: `#42`）を指定した場合:

```
redmine_issues action=get query="{\"id\": \"42\"}"
```

### 2. 内容確認

- 概要、説明、担当者、ステータス、優先度をチェック
- 未着手なら着手、進行中なら継続、完了済みなら確認

### 3. 実装

- チケットの要件に基づき実装
- 進捗は随時ジャーナルに記録

### 4. 完了報告

```
redmine_issues action=update issue_id=\"42\" issue=\"{\\\"status_id\\\": \\\"5\\\"}\"
```

## Redmine ツール一覧

| ツール | 用途 |
|---|---|
| `redmine_issues` | チケットの CRUD |
| `redmine_issue_journals` | ジャーナル（コメント） |
| `redmine_issue_relations` | チケット関連付け |
| `redmine_users` | ユーザー情報 |
| `redmine_projects` | プロジェクト情報 |
| `redmine_trackers` | トラッカー一覧 |
| `redmine_issue_statuses` | ステータス一覧 |
| `redmine_issue_categories` | カテゴリ一覧 |
| `redmine_enumerations` | 列挙型（優先度等） |
| `redmine_wiki` | Wiki ページ |
| `redmine_documents` | ドキュメント |
| `redmine_files` | ファイル |
| `redmine_versions` | バージョン |
| `redmine_groups` | グループ |
| `redmine_memberships` | メンバーシップ |
| `redmine_news` | ニュース |
| `redmine_queries` | 保存クエリ |
| `redmine_search` | 全文検索 |
| `redmine_paginated_request` | 全ページ取得 |
| `redmine_current_user` | 現在のユーザー |
| `redmine_custom_fields` | カスタムフィールド |
| `redmine_upload_file` | ファイルアップロード |
| `redmine_attachments` | 添付ファイル |

## 状態遷移ルール

```
New → In Progress → Resolved → Closed
                      ↘ Feedback → In Progress → ...
```

- `In Progress` に変更: 開発着手
- `Resolved` に変更: 実装完了、テスト通過
- `Closed` に変更: 検証完了

## ジャーナル記録

進捗があるたびにコメントを追加:

```
redmine_issues action=add_note issue_id=\"42\" notes=\"実装中: ○○機能\"
```
