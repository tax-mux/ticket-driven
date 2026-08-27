---
name: ticket-update
description: 既存Redmineチケットの状態・情報を更新する。進捗率・担当者・ステータス変更を含む。
---
# チケット更新

既存チケットの状態・情報を更新する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 更新可能フィールド・基本 PUT 例 | `sections/fields.md` |
| 説明更新の必須ルール・テンプレ・完了チェック | `sections/description.md` |
| 進捗率・担当者・ステータス・コメントのみの例 | `sections/common-updates.md` |

## 概要

### MCP 約束（この環境）

- 更新・ノートは **`mcp-redmine_redmine_issues`** の `action: "update"`（フラット引数）
- `issue_id` は **文字列**（`"42"`）。誤って `id` キーを使わない
- ジャーナルだけなら `notes` のみ。`add_note` action は **無い**
- ステータス ID は **`mcp-redmine_redmine_metadata`** `kind: "issue_statuses"` で確認
- 認証トークンは渡さない
- relations 等だけ **`mcp-redmine_redmine_api_request`**

### 基本的な更新

```json
{
  "action": "update",
  "issue_id": "42",
  "status_id": 2,
  "notes": "着手: 概要"
}
```

ツール: `mcp-redmine_redmine_issues`（`42` を実 ID に置換）

完了条件やテスト範囲が更新されていない場合は、チケットを解決してはいけない。説明まわりは `description.md`。
