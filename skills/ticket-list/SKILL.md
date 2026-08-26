---
name: ticket-list
description: 条件に合うRedmineチケットを取得する。ステータス/担当者/トラッカー別フィルタ、ページネーション対応。
---
# チケット一覧取得

条件に合うチケットを取得する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| status / assignee / tracker の list 例 | `sections/filters.md` |
| ページ送り・クエリパラメータ表 | `sections/pagination.md` |
| journals 等の詳細 get | `sections/detail-get.md` |

## 概要

### MCP 約束（この環境）

- 一覧は **`redmine_issues`** の `action: "list"`
- フィルタはトップレベルではなく **`query` オブジェクト**
- `include` が必要な詳細取得は `get`（配列）。list の include 文字列は使わない
- ページをまたぐ大量取得は `redmine_api_request` で `offset` / `limit` を回す（`redmine_paginated_request` は無い）

最小例:

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
