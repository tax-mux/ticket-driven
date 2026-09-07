# よく使う更新例

ツール: **`mcp-redmine_redmine_issues`**（`action: "update"`）。`issue_id` は文字列。

## 進捗率更新（解決の前または同時）

ステータスがまだ新規/進行中のとき（または解決と同一リクエスト）:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "done_ratio": 50
}
```

完了時の推奨（rate と解決を同時）:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "done_ratio": 100,
  "status_id": 3,
  "notes": "完了: ... — テスト: ..."
}
```

**禁止**: 先に `status_id: 3` だけ送り、あとから `done_ratio` だけ直す。**禁止**: `status_id: 5`（終了）をエージェントが使うこと。

update 後は必要なら `get` で反映を確認。ACK だけでは不十分。

## 担当者変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "assigned_to_id": 1
}
```

## ステータス変更

進行中:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 2
}
```

解決（完了。必要なら同じリクエストに `done_ratio: 100`）:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "status_id": 3,
  "done_ratio": 100
}
```

## コメントのみ（推奨）

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "notes": "進捗中: ..."
}
```

## 説明 + ノート

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "description": "{更新後の本文}",
  "notes": "説明を精緻化"
}
```
