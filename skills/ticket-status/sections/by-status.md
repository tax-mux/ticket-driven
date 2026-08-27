# ステータス別アクション

## New（新規）

1. チケット内容を確認
2. 要件を分解
3. 担当者確認
4. ステータス ID を取得（`mcp-redmine_redmine_metadata` `kind: "issue_statuses"`）
5. ステータスを `進行中` に変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 2,
  "notes": "着手: 概要"
}
```

ツール: `mcp-redmine_redmine_issues`（進行中 ID は目安 `2`。必ず metadata で確認）

## In Progress（進行中）

1. 既存のジャーナルを確認（`mcp-redmine_redmine_issues` get + `include: ["journals"]`）
2. 実装実行
3. 進捗をジャーナルに記録（`update` + `notes`）

## Feedback（フィードバック）

1. 指摘内容を確認
2. 修正実施
3. ステータスを `進行中` に再変更（`update` + `status_id: 2`）

## Resolved（解決）

1. テスト・検証
2. 要件充足確認
3. 完了報告をジャーナルに追加（`update` + `notes` + `status_id: 3`）

## Closed（終了）

- 完了確認済み。特にアクション不要。
