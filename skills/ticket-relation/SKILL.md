---
name: ticket-relation
description: Redmineチケット間の依存関係・関連付けを管理する。関連種別追加・削除・一覧取得。
---
# チケット関連付け

チケット間の依存関係・関連付けを管理する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 関連種別の一覧 | `sections/types.md` |
| 追加・削除・一覧の API 例 | `sections/api.md` |

## 概要

### MCP 約束（この環境）

- `redmine_issue_relations` ツールは無い。すべて **`redmine_api_request`**
- `relation` / `body` はオブジェクト

分割後の順序依存は `precedes` / `blocks` 等で明示（単なる `relates` だけにしない）。種別は `types.md`、操作例は `api.md`。
