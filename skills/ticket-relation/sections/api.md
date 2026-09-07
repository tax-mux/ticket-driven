# 関連付け API

## 関連付け追加

```json
{
  "method": "POST",
  "path": "/issues/{ID}/relations.json",
  "body": {
    "relation": {
      "issue_to_id": "{CHILD_ID}",
      "relation_type": "relates",
      "delay": 0
    }
  }
}
```

ツール: `redmine_api_request`

## 関連付け削除

```json
{
  "method": "DELETE",
  "path": "/relations/{関係ID}.json"
}
```

## 関連一覧取得

```json
{
  "action": "get",
  "issue_id": "{ID}",
  "include": ["relations"]
}
```

ツール: `redmine_issues`（または `GET /issues/{ID}/relations.json`）
