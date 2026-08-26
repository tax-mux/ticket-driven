# 条件指定（`redmine_issues`）

## ステータス別

```json
{
  "action": "list",
  "limit": 25,
  "query": {
    "status_id": "open",
    "project_id": "{プロジェクト}"
  }
}
```

## 担当者別

```json
{
  "action": "list",
  "query": {
    "assigned_to_id": "{ユーザーID}",
    "project_id": "{プロジェクト}"
  }
}
```

## トラッカー別

```json
{
  "action": "list",
  "query": {
    "tracker_id": "{トラッカーID}",
    "project_id": "{プロジェクト}"
  }
}
```
