# チケット作成ガイド

Redmine に新しいチケットを作成する手順。

## チケット作成

```
redmine_issues action=create issue=\"{
  \\\"project_id\\\": \\\"{プロジェクトID}\\\",
  \\\"tracker_id\\\": {トラッカーID},
  \\\"subject\\\": \\\"タイトル\\\",
  \\\"description\\\": \\\"説明\\\",
  \\\"priority_id\\\": {優先度ID},
  \\\"category_id\\\": {カテゴリID},
  \\\"assigned_to_id\\\": {担当者ID}
}\"
```

## 必須フィールド

- `project_id`: プロジェクト（ID または識別子）
- `tracker_id`: トラッカー（bug, task, feature 等）
- `subject`: タイトル

## 任意フィールド

- `description`: 詳細説明
- `priority_id`: 優先度（デフォルト: normal）
- `category_id`: カテゴリ
- `assigned_to_id`: 担当者
- `observer_ids`: 観測者
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
