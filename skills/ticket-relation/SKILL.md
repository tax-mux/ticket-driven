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
| `depends on` | 依存（これが終わらないと次が始まらない） |
| `dependent` | 被依存（これが終わらないと前が始まらない） |
| `duplicates` | 重複 |
| `starts` | 開始（これが始まったら次も始まる） |
| `ended by` | 終了（これが終わったら前も終わる） |
| `copies` | コピー |
| `clones` | クローン |

## 関連付け追加

```
redmine_issue_relations action=create issue_id=\"{ID}\" relation=\"{
  \\\"issue_to_id\\\": {関連チケットID},
  \\\"relation_type\\\": \\\"depends on\\\",
  \\\"delay\\\": 0
}\"
```

## 関連付け削除

```
redmine_issue_relations action=delete issue_id=\"{ID}\" relation_id=\"{関係ID}\"
```

## 関連一覧取得

```
redmine_issue_relations action=list issue_id=\"{ID}\"
```
