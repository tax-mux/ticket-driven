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

- 更新・ノートは **`redmine_api_request`** の `PUT /issues/{id}.json`
- `issue_id` はパスに入れる（引数名 `id` は使わない）
- `body.issue` はオブジェクト。JSON 文字列にしない
- `redmine_issues` は **list / get のみ**

### 基本的な更新

```json
{
  "method": "PUT",
  "path": "/issues/42.json",
  "body": {
    "issue": {
      "status_id": 2,
      "notes": "コメント"
    }
  }
}
```

ツール: `redmine_api_request`（`42` を実 ID に置換）

完了条件やテスト範囲が更新されていない場合は、チケットを解決してはいけない。説明まわりは `description.md`。
