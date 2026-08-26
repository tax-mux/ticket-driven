# 作成 API・フィールド

## チケット作成

```json
{
  "method": "POST",
  "path": "/issues.json",
  "body": {
    "issue": {
      "project_id": "{プロジェクトID}",
      "tracker_id": 2,
      "subject": "タイトル",
      "description": "説明",
      "priority_id": 2,
      "category_id": 1,
      "assigned_to_id": 1
    }
  }
}
```

ツール: `redmine_api_request`

トラッカー一覧が必要なら:

```json
{ "method": "GET", "path": "/trackers.json" }
```

## 必須フィールド

- `project_id`: プロジェクト（ID または識別子）
- `tracker_id`: トラッカー
- `subject`: タイトル

## 任意フィールド

- `description`: 詳細説明
- `priority_id`: 優先度（デフォルト: normal）
- `category_id`: カテゴリ
- `assigned_to_id`: 担当者
- `watcher_user_ids`: ウォッチャー
- `start_date`: 開始日
- `due_date`: 期限
- `custom_fields`: カスタムフィールド
- `parent_issue_id`: 親チケット
