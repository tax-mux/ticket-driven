# チケット更新

既存チケットの状態・情報を更新する。

## 基本的な更新

```
redmine_issues action=update issue_id=\"{ID}\" issue=\"{
  \\\"status_id\\\": {ステータスID},
  \\\"notes\\\": \\\"コメント\\\"
}\"
```

## 更新可能なフィールド

| フィールド | 説明 |
|---|---|
| `status_id` | ステータス |
| `priority_id` | 優先度 |
| `assigned_to_id` | 担当者 |
| `category_id` | カテゴリ |
| `due_date` | 期限 |
| `start_date` | 開始日 |
| `done_ratio` | 進捗率 |
| `custom_fields` | カスタムフィールド |
| `notes` | ジャーナルコメント |

## 進捗率更新

```
redmine_issues action=update issue_id=\"{ID}\" issue=\"{\\\"done_ratio\\\": 50}\"
```

## 担当者変更

```
redmine_issues action=update issue_id=\"{ID}\" issue=\"{\\\"assigned_to_id\\\": {ユーザーID}}\"
```

## ステータス変更

```
redmine_issues action=update issue_id=\"{ID}\" issue=\"{\\\"status_id\\\": {ステータスID}}\"
```
