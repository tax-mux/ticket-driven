---
name: ticket-driven
description: チケット駆動開発の全体ワークフロー。Redmineチケットを起点に開発タスクを駆動する。
---
# チケット駆動開発 (Ticket-Driven Development)

Redmine チケットを起点に開発タスクを駆動する。

## スキルトリガー

| 生発音（ローマ字） | パス |
|---|---|
| ticketcreate | skills/ticket-create.md |
| ticketstatus | skills/ticket-status.md |
| ticketupdate | skills/ticket-update.md |
| ticketlist | skills/ticket-list.md |
| ticketrelation | skills/ticket-relation.md |
| ticketrefine | skills/ticket-refine.md |
| ticketsplit | skills/ticket-split.md |

## ワークフロー

### 0. 着手前チェックリスト

チケット着手前に必ず確認:

- [ ] リモートリポジトリが確保されているか（`git remote -v`）
- [ ] 概要・説明が明確か（null または曖昧なら精緻化を優先）
- [ ] 完了条件が定義されているか
- [ ] 実装方針が具体化されているか
- [ ] 分割が必要な.large チケットでないか

#### リモートリポジトリ未確保の場合

1. チケットのコメントに「リポジトリ未作成」を登録
2. チケットを保留にする
3. リポジトリ作成後に再開

### 1. チケット取得

ユーザーがチケット番号（例: `#42`）を指定した場合:

```
redmine_issues action=get issue_id="42" include="journals,attachments"
```

### 2. 関連チケットの把握

親チケットが指定された場合、子チケットも自動的に連携対象とする。

```
redmine_issue_relations action=list issue_id="42"
```

- 子チケットがある場合は一覧を取得し、全てを処理対象とする
- 子チケットが未着手の場合は着手する

### 3. 内容確認と精緻化

概要、説明、担当者、ステータス、優先度をチェック:

| ステータス | 対応 |
|-----------|------|
| 新規 | 精緻化 → 分割（必要に応じて）→ 着手 |
| 進行中 | 継続 |
| 解決 | 検証 |
| 閉鎖 | 確認 |

#### 3.1 精緻化（説明が不足の場合）

`ticket-refine` スキルを適用:

- 背景・目的を明確化
- 機能要件・非機能要件を列挙
- 完了条件を具体化
- 実装方針を提案

#### 3.2 細分化（範囲が広い場合）

`ticket-split` スキルを適用:

- 機能単位で独立した子チケットに分割
- 依存関係を明確化
- 各チケットの完了条件を定義

### 4. 実装

- チケットの要件に基づき実装
- 進捗は随時ジャーナルに記録

```
redmine_issues action=add_note issue_id="42" notes="実装中: 〇〇機能"
```

### 5. ステータス遷移

Redmine のステータス一覧を取得して適切な遷移を行う:

```
redmine_issue_statuses action=list
```

標準遷移:

```
New → In Progress → Resolved → Closed
                      ↘ Feedback → In Progress → ...
```

- `In Progress` に変更: 開発着手
- `Resolved` に変更: 実装完了、テスト通過
- `Closed` に変更: 検証完了

### 6. 説明更新

完了前に説明を更新:

```
redmine_issues action=update issue_id="42" issue="{\"description\": \"{更新後の説明}\"}"
```

**必須項目**:
- リモートリポジトリURL
- 完了条件
- テスト範囲
- 影響範囲

### 7. 完了報告

説明更新後、ステータスを解決に変更:

```
redmine_issues action=update issue_id="42" issue="{\"status_id\": <ResolvedのID>}"
```

**完了チェックリスト**:
- [ ] 説明にリポジトリURLが記載
- [ ] 完了条件が更新
- [ ] テスト範囲が記載
- [ ] ジャーナルに進捗記録

### 8. コミットとPR

作業完了後、必ずコミットしてPRを作成する。

#### 8.1 コミット

```
git status
git diff
git log -5 --oneline
```

変更をステージング:

```
git add {ファイルパス}
```

コミットメッセージ:

```
git commit -m "$(cat <<'EOF'
{type}: {概要}

{詳細（必要に応じて）}

EOF
)"
```

type: feat, fix, docs, style, refactor, test, chore

#### 8.2 PR作成

```
git push -u origin HEAD
gh pr create --title "{タイトル}" --body "$(cat <<'EOF'
## 概要
<1-3行で概要>

## 変更内容
- {変更1}
- {変更2}

## テスト
- [ ] {テスト1}
- [ ] {テスト2}

## 備考
{補足情報}

EOF
)"
```

**必須**:
- リモートリポジトリURLをPR本文に記載
- テスト範囲を記載
- 関連チケットを記載（例: `Refs: #42`）

## Redmine 主要ツール

| ツール | 用途 |
|---|---|
| `redmine_issues` | チケットの CRUD |
| `redmine_issue_journals` | ジャーナル（コメント） |
| `redmine_issue_relations` | チケット関連付け |
| `redmine_issue_statuses` | ステータス一覧 |
| `redmine_users` | ユーザー情報 |
| `redmine_projects` | プロジェクト情報 |
| `redmine_trackers` | トラッカー一覧 |
| `redmine_paginated_request` | 全ページ取得 |
| `redmine_search` | 全文検索 |
| `redmine_upload_file` | ファイルアップロード |

## ジャーナル記録テンプレート

| タイミング | フォーマット |
|-----------|-------------|
| 着手 | `着手: {概要}` |
| 進捗 | `進捗中: {具体的な作業内容}（{進捗率}%）` |
| 完了 | `完了: {概要} — {検証結果}` |
| 分割 | `分割: #{子ID1} {タイトル1}, #{子ID2} {タイトル2}` |
| 精緻化 | `精緻化: {変更内容の要約}` |
