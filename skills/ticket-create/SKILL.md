---
name: ticket-create
description: Redmineに新しいチケットを作成する。必須/任意フィールド、種別別テンプレート付き。
---
# チケット作成ガイド

Redmine に新しいチケットを作成する手順。

## チケット作成

```json
{
  "action": "create",
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
```

ツール: `redmine_issues`（`issue` は **オブジェクト**。JSON文字列にしない）

## 必須フィールド

- `project_id`: プロジェクト（ID または識別子）
- `tracker_id`: トラッカー（ID を取得: `redmine_trackers` `action=list`）
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
