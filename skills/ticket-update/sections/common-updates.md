# よく使う更新例

ツール: **`mcp-redmine_redmine_issues`**（`action: "update"`）。`issue_id` は文字列。

## 進捗率更新

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "done_ratio": 50
}
```

## 担当者変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "assigned_to_id": 1
}
```

## ステータス変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 3
}
```

## コメントのみ（推奨）

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "notes": "進捗中: ..."
}
```

## 説明 + ノート

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "description": "{更新後の本文}",
  "notes": "説明を精緻化"
}
```
