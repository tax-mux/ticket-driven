---
name: ticket-list
description: 条件に合うRedmineチケットを取得する。ステータス/担当者/トラッカー別フィルタ、ページネーション対応。
---
# チケット一覧取得

条件に合うチケットを取得する。

## MCP 約束（この環境）

- 一覧は **`redmine_issues`** の `action: "list"`
- フィルタはトップレベルではなく **`query` オブジェクト**
- `include` が必要な詳細取得は `get`（配列）。list の include 文字列は使わない
- ページをまたぐ大量取得は `redmine_api_request` で `offset` / `limit` を回す（`redmine_paginated_request` は無い）

## 条件指定（`redmine_issues`）

### ステータス別

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

### 担当者別

```json
{
  "action": "list",
  "query": {
    "assigned_to_id": "{ユーザーID}",
    "project_id": "{プロジェクト}"
  }
}
```

### トラッカー別

```json
{
  "action": "list",
  "query": {
    "tracker_id": "{トラッカーID}",
    "project_id": "{プロジェクト}"
  }
}
```

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

## 詳細（journals 等）

```json
{
  "action": "get",
  "issue_id": "42",
  "include": ["journals", "watchers", "children"]
}
```

ツール: `redmine_issues`
