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

- チケット一覧は **`mcp-redmine_redmine_issues`** の `action: "list"`
- プロジェクト一覧は **`mcp-redmine_redmine_projects`** の `action: "list"`
- フィルタはトップレベルではなく **`query` オブジェクト**
- `include` が必要な詳細取得は `get`（配列）。list の include 文字列は使わない
- **list に description は付かない**（MCP 側で除去）。本文は `get` でドリルダウン
- ページをまたぐ大量取得は `redmine_issues` list の `query` に `offset` / `limit`、または `mcp-redmine_redmine_api_request`（`redmine_paginated_request` は **無い**）

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

プロジェクト一覧:

```json
{ "action": "list" }
```

ツール: `mcp-redmine_redmine_projects`
