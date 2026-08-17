---
name: ticket-update
description: 既存Redmineチケットの状態・情報を更新する。進捗率・担当者・ステータス変更を含む。
---
# チケット更新

既存チケットの状態・情報を更新する。

## MCP 約束（この環境）

- 更新・ノートは **`redmine_api_request`** の `PUT /issues/{id}.json`
- `issue_id` はパスに入れる（引数名 `id` は使わない）
- `body.issue` はオブジェクト。JSON 文字列にしない
- `redmine_issues` は **list / get のみ**

## 基本的な更新

```json
{
  "method": "PUT",
  "path": "/issues/42.json",
  "body": {
    "issue": {
      "status_id": 2,
      "notes": "コメント"
    }
  }
}
```

ツール: `redmine_api_request`（`42` を実 ID に置換）

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

完了条件が未チェック、またはテスト範囲が `ticket-refine` の合格ラインを満たさないときは、チケットを解決してはいけない。

完了時に **薄いテンプレで description を差し替えない。** 精緻化・分割で厚くした本文（範囲・失敗時・DoD 対応のテスト）を保つ。

### 必須ルール

1. **説明にリモートリポジトリURLが無ければ足す**（あるなら触らない）
2. **作業区切りごとにジャーナルにコメント**（進捗の連投は不要）
3. **完了前は既存本文を直すだけ**: 完了条件を `[x]` にする。テスト範囲が言い換えだけなら合格ラインまで直す。見出しセットの作り直しはしない
4. **欠けを埋めてから解決する**
5. **コミットと PR はユーザー依頼時、または完了条件に含まれるときだけ**（`ticket-driven` に同じ）

### 完了時にやること

```
既存の description を読む
 → 完了条件の [ ] を [x] にする
 → リポジトリURLが無ければ影響範囲または環境に1行足す
 → テスト範囲が DoD の言い換えだけなら、ticket-refine の合格ラインまで直す
 → テンプレ全体への差し替えはしない
```

途中の説明更新も欠け埋めだけ。新規起票用の薄い骨組み（背景・実装内容・テスト対象の箇条書きだけ）は使わない。

### 更新手順

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": { "issue": { "description": "{既存本文を直したもの}" } }
}
```

### 完了チェック

- [ ] 説明にリポジトリURLがある
- [ ] 完了条件がすべて `[x]`（未検証のまま Resolved しない）
- [ ] テスト範囲が `ticket-refine` の合格ラインを満たす（「記載がある」だけでは不合格）
- [ ] ジャーナルに完了ノートがある
- [ ] コミット済み（依頼時）
- [ ] PR作成済み（依頼時）

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
