---
name: ticket-list
description: 条件に合うRedmineチケットを取得する。ステータス/担当者/トラッカー別フィルタ、ページネーション対応。
---
# チケット一覧取得

条件に合うチケットを取得する。

## 全件取得（ページネーション対応）

```json
{
  "path": "/issues.json",
  "query": { "project_id": "{プロジェクト}" },
  "limit": 100
}
```

ツール: `redmine_paginated_request`

## 条件指定（`redmine_issues`）

`list` ではフィルタをトップレベルに置いても、`query` オブジェクトにまとめてもよい。

### ステータス別

```json
{
  "action": "list",
  "status_id": "open",
  "project_id": "{プロジェクト}"
}
```

### 担当者別

```json
{
  "action": "list",
  "assigned_to_id": "{ユーザーID}",
  "project_id": "{プロジェクト}"
}
```

### トラッカー別

```json
{
  "action": "list",
  "tracker_id": "{トラッカーID}",
  "project_id": "{プロジェクト}"
}
```

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
| `include` | 含む情報（journals, watchers, children）※カンマ区切り文字列 |

## 含む情報

```json
{
  "action": "list",
  "status_id": "open",
  "include": "journals,watchers"
}
```
