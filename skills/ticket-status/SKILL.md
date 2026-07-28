---
name: ticket-status
description: チケットのステータスに応じた対応手順。ステータス別アクションと優先度別対応を含む。
---
# チケット状態別アクション

チケットのステータスに応じた対応手順。

## ステータス別アクション

### New（新規）

1. チケット内容を確認
2. 要件を分解
3. 担当者確認
4. ステータスIDを取得: `redmine_issue_statuses` `action=list`
5. ステータスを `進行中` に変更

```json
{ "action": "list" }
```
ツール: `redmine_issue_statuses`

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": { "status_id": 2 }
}
```
ツール: `redmine_issues`（本環境の進行中 ID は `2`。必ず `list` で確認）

### In Progress（進行中）

1. 既存のジャーナルを確認
2. 実装実行
3. 進捗をジャーナルに記録（適宜）

### Feedback（フィードバック）

1. 指摘内容を確認
2. 修正実施
3. ステータスを `進行中` に再変更

### Resolved（解決）

1. テスト・検証
2. 要件充足確認
3. 完了報告をジャーナルに追加

### Closed（終了）

- 完了確認済み。特にアクション不要。

## 優先度別対応

| 優先度 | 対応 |
|---|---|
| urgent | 即座に着手 |
| high | 現在のタスク優先 |
| normal | 通常スケジューリング |
| low | 空き時間 |
