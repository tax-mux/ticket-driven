# 作成 API・フィールド

## チケット作成（推奨）

```json
{
  "action": "create",
  "project_id": "{プロジェクトIDまたはidentifier}",
  "tracker_id": 2,
  "status_id": 1,
  "subject": "タイトル",
  "description": "説明",
  "priority_id": 2,
  "assigned_to_id": 1
}
```

ツール: `mcp-redmine_redmine_issues`

トラッカー / ステータス ID が不明なら先に:

```json
{ "kind": "all" }
```

ツール: `mcp-redmine_redmine_metadata`

## 必須フィールド（create）

- `project_id`: プロジェクト（ID または識別子）
- `tracker_id`: トラッカー
- `status_id`: ステータス（新規は通常 `1`）
- `subject`: タイトル
- `description`: 詳細説明

## 任意フィールド

- `priority_id`: 優先度
- `assigned_to_id`: 担当者
- `parent_id`: 親チケット
- `due_date`: 期限（`YYYY-MM-DD`）
- `estimated_hours`: 予定時間

## 逃げ道（relations 等のみ）

```json
{
  "method": "POST",
  "path": "/issues.json",
  "body": {
    "issue": {
      "project_id": "{プロジェクトID}",
      "tracker_id": 2,
      "subject": "タイトル",
      "description": "説明"
    }
  }
}
```

ツール: `mcp-redmine_redmine_api_request`（**create は上記 issues を優先**）
