---
name: ticket-create
description: Redmineに新しいチケットを作成する。必須/任意フィールド、種別別テンプレート付き。
---
# チケット作成ガイド

Redmine に新しいチケットを作成する手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| POST 例・必須/任意フィールド | `sections/fields.md` |
| Bug / Feature / Task の本文テンプレ | `sections/templates.md` |
| 障害・エラー（現象確認→調査→解決の親） | `sections/bug-flow.md` |

## 概要

### MCP 約束（この環境）

- 作成は **`mcp-redmine_redmine_issues`** の `action: "create"`（フラット引数）
- `project_id`, `tracker_id`, `status_id`, `subject`, `description` をトップレベルに渡す
- `body` / `issue` は **オブジェクト**。JSON 文字列にしない
- トラッカー ID が不明なら先に **`mcp-redmine_redmine_metadata`** `kind: "trackers"`
- 認証トークンは渡さない（プロファイルはヘッダ側）
- relations 等だけ **`mcp-redmine_redmine_api_request`**

### 作成必須項目（本文）

- [ ] 背景
- [ ] 環境
- [ ] 実装内容
- [ ] 完了条件（チェックリスト）
- [ ] 影響範囲
- [ ] テスト範囲

フィールドと POST 例は `fields.md`。種別テンプレは `templates.md`。障害・失敗修正は `bug-flow.md`（分析し切ってから起票しない）。起票後の充足は `ticket-refine`。
