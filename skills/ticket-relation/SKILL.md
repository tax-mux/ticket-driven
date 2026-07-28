---
name: ticket-relation
description: Redmineチケット間の依存関係・関連付けを管理する。関連種別追加・削除・一覧取得。
---
# チケット関連付け

チケット間の依存関係・関連付けを管理する。

## 関連種別

| 関係 | 説明 |
|---|---|
| `relates` | 関連 |
| `precedes` | 先行（これが終わると次が可能） |
| `follows` | 後続 |
| `blocks` | ブロック |
| `blocked` | 被ブロック |
| `duplicates` | 重複 |
| `duplicated` | 被重複 |
| `copied_to` | コピー先 |
| `copied_from` | コピー元 |

※ Redmine の表記は環境により異なる。不明なら作成前に既存 relation を確認する。

## 関連付け追加

```json
{
  "action": "create",
  "issue_id": "{ID}",
  "relation": {
    "issue_to_id": 43,
    "relation_type": "relates",
    "delay": 0
  }
}
```

ツール: `redmine_issue_relations`（`relation` はオブジェクト）

## 関連付け削除

```json
{
  "action": "delete",
  "relation_id": "{関係ID}"
}
```

## 関連一覧取得

```json
{
  "action": "list",
  "issue_id": "{ID}"
}
```
