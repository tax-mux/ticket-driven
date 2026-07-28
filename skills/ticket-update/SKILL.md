---
name: ticket-update
description: 既存Redmineチケットの状態・情報を更新する。進捗率・担当者・ステータス変更を含む。
---
# チケット更新

既存チケットの状態・情報を更新する。

## 基本的な更新

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": {
    "status_id": 2,
    "notes": "コメント"
  }
}
```

ツール: `redmine_issues`（`issue` / `issue_id` はオブジェクトと文字列。エスケープ済みJSON文字列にしない）

## 更新可能なフィールド

| フィールド | 説明 |
|---|---|
| `status_id` | ステータス |
| `priority_id` | 優先度 |
| `assigned_to_id` | 担当者 |
| `category_id` | カテゴリ |
| `due_date` | 期限 |
| `start_date` | 開始日 |
| `done_ratio` | 進捗率 |
| `custom_fields` | カスタムフィールド |
| `notes` | ジャーナルコメント |
| `description` | 説明 |

## 説明の更新

完了条件やテスト範囲が更新されていない場合は、チケットを解決してはいけない。

### 必須ルール

1. **説明には必ずリモートリポジトリURLを記述**
2. **作業区切りごとにジャーナルにコメント**
3. **完了前に説明を更新（完了条件・テスト範囲）**
4. **説明が更新されてから解決**
5. **作業完了後、必ずコミットしてPRを作成**

### 説明テンプレート

```
## 背景
{現在の状況と問題点}

## 環境
- リポジトリ: {リモートリポジトリURL}
- 種別: {GitBucket/GitHub等}
- プッシュ先: {origin URL}

## 実装内容
{具体的に何をするか}

## 完了条件
- [ ] {条件1}
- [ ] {条件2}

## 影響範囲
- {ファイルパス}

## テスト範囲
- {テスト対象}
```

### 更新手順

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": { "description": "{更新後の説明}" }
}
```

### 完了チェック

- [ ] 説明にリポジトリURLが記載
- [ ] 完了条件が更新
- [ ] テスト範囲が記載
- [ ] ジャーナルに進捗記録
- [ ] コミット済み
- [ ] PR作成済み

## 進捗率更新

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": { "done_ratio": 50 }
}
```

## 担当者変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": { "assigned_to_id": 1 }
}
```

## ステータス変更

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "issue": { "status_id": 3 }
}
```

## コメントのみ（推奨）

```json
{
  "action": "add_note",
  "issue_id": "{ID}",
  "notes": "進捗中: ..."
}
```
