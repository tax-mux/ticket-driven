# よく使う更新例

## 進捗率更新

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "done_ratio": 50 } }
}
```

## 担当者変更

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "assigned_to_id": 1 } }
}
```

## ステータス変更

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "status_id": 3 } }
}
```

## コメントのみ（推奨）

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "notes": "進捗中: ..." } }
}
```
