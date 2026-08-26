# ステータス別アクション

## New（新規）

1. チケット内容を確認
2. 要件を分解
3. 担当者確認
4. ステータスIDを取得
5. ステータスを `進行中` に変更

```json
{ "method": "GET", "path": "/issue_statuses.json" }
```

ツール: `redmine_api_request`

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "status_id": 2 } }
}
```

ツール: `redmine_api_request`（本環境の進行中 ID は目安 `2`。必ず statuses で確認）

## In Progress（進行中）

1. 既存のジャーナルを確認（`redmine_issues` get + `include: ["journals"]`）
2. 実装実行
3. 進捗をジャーナルに記録（適宜）

## Feedback（フィードバック）

1. 指摘内容を確認
2. 修正実施
3. ステータスを `進行中` に再変更

## Resolved（解決）

1. テスト・検証
2. 要件充足確認
3. 完了報告をジャーナルに追加

## Closed（終了）

- 完了確認済み。特にアクション不要。
