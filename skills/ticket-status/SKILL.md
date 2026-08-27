---
name: ticket-status
description: チケットのステータスに応じた対応手順。ステータス別アクションと優先度別対応を含む。
---
# チケット状態別アクション

チケットのステータスに応じた対応手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| New / In Progress / Feedback / Resolved / Closed の手順 | `sections/by-status.md` |
| 優先度別の対応表 | `sections/by-priority.md` |

## 概要

### MCP 約束（この環境）

- ステータス一覧: **`mcp-redmine_redmine_metadata`** `{ "kind": "issue_statuses" }`
- ステータス変更: **`mcp-redmine_redmine_issues`** `action: "update"` + `status_id`
- `redmine_issue_statuses` / `GET /issue_statuses.json` 専用ツールは **無い**（metadata を使う）

日常の着手〜完了は `ticket-driven` を優先。本スキルはステータスごとの補助手順。
