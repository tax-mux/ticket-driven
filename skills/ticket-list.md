# チケット一覧取得

条件に合うチケットを取得する。

## 全件取得（ページネーション対応）

```
redmine_paginated_request path=\"/issues.json\" query=\"{\\\"project_id\\\": \\\"{プロジェクト}\\\"}\"
```

## 条件指定

### ステータス別

```
redmine_issues action=list query=\"{\\\"status_id\\\": \\\"open\\\", \\\"project_id\\\": \\\"{プロジェクト}\\\"}\"
```

### 担当者別

```
redmine_issues action=list query=\"{\\\"assigned_to_id\\\": \\\"{ユーザーID}\\\", \\\"project_id\\\": \\\"{プロジェクト}\\\"}\"
```

### トラッカー別

```
redmine_issues action=list query=\"{\\\"tracker_id\\\": \\\"{トラッカーID}\\\", \\\"project_id\\\": \\\"{プロジェクト}\\\"}\"
```

## 主要クエリパラメータ

| パラメータ | 説明 |
|---|---|
| `project_id` | プロジェクト |
| `status_id` | ステータス（open, closed, 個別ID） |
| `assigned_to_id` | 担当者 |
| `tracker_id` | トラッカー |
| `category_id` | カテゴリ |
| `priority_id` | 優先度 |
| `cf_1` | カスタムフィールド（ID） |
| `q` | 全文検索キーワード |
| `include` | 含む情報（journals, watchers, children） |

## 含む情報

```
redmine_issues action=list query=\"{\\\"status_id\\\": \\\"open\\\", \\\"include\\\": \\\"journals,watchers\\\"}\"
```
