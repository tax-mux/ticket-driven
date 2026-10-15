# ステータス別アクション

ID は環境により異なる。変更前に必ず `mcp-redmine_redmine_metadata` `kind: "issue_statuses"` で確認する。

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
4. 実装検証が終わったら **レビュー** へ（進行中のまま解決しない）

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 7,
  "notes": "レビュー提出: 実装検証済み。ticket-evaluate 待ち。"
}
```

レビュー ID は本環境目安 `7`。必ず metadata で確認。

## Review（レビュー）

LLM 実装評価待ち。人の「フィードバック」とは別。

1. `ticket-evaluate` で `評価:` を **notes のみ**追記（status は触らない）
2. **不合格**: 実装側が進行中へ差し戻し

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 2,
  "notes": "差し戻し: 評価不合格 — {要約}"
}
```

3. **合格 / 条件付き合格（ブロッカーなし）**: 実装側がクローズ監査のうえ解決へ（下記 Resolved）

## Feedback（フィードバック）

人からの差し戻し・確認待ち用。**LLM の実装評価には使わない**（レビューを使う）。

1. 指摘内容を確認
2. 修正実施
3. ステータスを `進行中` に再変更（`update` + `status_id: 2`）

## Resolved（解決）

前提: 票が **レビュー** であり、journals に合格系の `評価:` がある（`ticket-driven` の close-audit）。

1. テスト・検証・クローズ監査（評価済み含む）
2. 要件充足確認
3. 完了報告をジャーナルに追加し、レビュー→解決（`update` + `notes` + `done_ratio: 100` + `status_id: 3`）

進行中から直に解決しない。

## Closed（終了）

- 完了確認済み。エージェント通常経路では使わない。特にアクション不要。
