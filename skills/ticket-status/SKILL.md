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

- ステータス一覧: `redmine_api_request` `GET /issue_statuses.json`
- ステータス変更: `redmine_api_request` `PUT /issues/{id}.json`
- `redmine_issue_statuses` ツールは無い

日常の着手〜完了は `ticket-driven` を優先。本スキルはステータスごとの補助手順。
