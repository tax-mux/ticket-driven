---
name: ticket-create
description: Redmineに新しいチケットを作成する。必須/任意フィールド、種別別テンプレート付き。
---
# チケット作成ガイド

Redmine に新しいチケットを作成する手順。

## MCP 約束（この環境）

- 作成は **`redmine_api_request`**（`redmine_issues` に create は無い）
- `body` はオブジェクト。JSON 文字列にしない
- 認証トークンは渡さない（プロファイルはヘッダ側）

## チケット作成

```json
{
  "method": "POST",
  "path": "/issues.json",
  "body": {
    "issue": {
      "project_id": "{プロジェクトID}",
      "tracker_id": 2,
      "subject": "タイトル",
      "description": "説明",
      "priority_id": 2,
      "category_id": 1,
      "assigned_to_id": 1
    }
  }
}
```

ツール: `redmine_api_request`

トラッカー一覧が必要なら:

```json
{ "method": "GET", "path": "/trackers.json" }
```

## 必須フィールド

- `project_id`: プロジェクト（ID または識別子）
- `tracker_id`: トラッカー
- `subject`: タイトル

## 任意フィールド

- `description`: 詳細説明
- `priority_id`: 優先度（デフォルト: normal）
- `category_id`: カテゴリ
- `assigned_to_id`: 担当者
- `watcher_user_ids`: ウォッチャー
- `start_date`: 開始日
- `due_date`: 期限
- `custom_fields`: カスタムフィールド
- `parent_issue_id`: 親チケット

## チケット作成必須項目

- [ ] 背景
- [ ] 環境
- [ ] 実装内容
- [ ] 完了条件（チェックリスト）
- [ ] 影響範囲
- [ ] テスト範囲

## チケット種別別テンプレート

### Bug

```
## 再現手順
1. ...
2. ...

## 期待値
...

## 実際
...

## 環境
- OS: ...
- バージョン: ...
```

### Feature

```
## 背景
...

## 目的
...

## 実装方針
...

## 完了条件
- [ ] ...
- [ ] ...
```

### Task

```
## 作業内容
...

## 手順
1. ...
2. ...

## 完了条件
...
```
