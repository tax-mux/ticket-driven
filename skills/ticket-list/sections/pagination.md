# ページ送りとクエリパラメータ

## ページ送り（大量）

```json
{
  "method": "GET",
  "path": "/issues.json",
  "query": {
    "project_id": "{プロジェクト}",
    "status_id": "open",
    "limit": "100",
    "offset": "0"
  }
}
```

ツール: `redmine_api_request`（`query` の値は文字列）

## 主要クエリパラメータ

| パラメータ | 説明 |
|---|---|
| `project_id` | プロジェクト |
| `status_id` | ステータス（open, closed, 個別ID） |
| `assigned_to_id` | 担当者 |
| `tracker_id` | トラッカー |
| `category_id` | カテゴリ |
| `priority_id` | 優先度 |
| `cf_1` | カスタムフィールド（ID） |
