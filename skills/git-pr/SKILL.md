---
name: git-pr
description: PR作成。gh cliまたはGitBucket API対応。diff確認、タイトル/本文生成。
---
# Pull Request作成

gh cliまたはGitBucket APIを使ってPRを作成する手順。

## 着手前チェックリスト

- [ ] `git status` でコミット済みか確認
- [ ] `git branch` で現在ブランチを確認
- [ ] `git log` でコミット履歴を確認
- [ ] `git diff main...HEAD` で変更範囲を確認

## PR作成手順

### 1. 現在の状態確認

```
git status
git diff main...HEAD
git log main..HEAD --oneline
```

### 2. リモートにプッシュ

```
git push -u origin HEAD
```

### 3. PR作成

#### GitHubの場合（gh cli利用可能）

```
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

#### GitBucketの場合（gh cliなし）

##### 3-1. diffの生成

```
git diff main...HEAD
```

##### 3-2. PR本文の生成

diffの内容を基に本文を生成:

- 変更したファイル一覧
- 各ファイルの変更内容
- テスト範囲

##### 3-3. PR作成

```
curl -s -X POST -u "{ユーザー名}:{パスワード}" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "{タイトル}",
    "body": "{本文（JSONエスケープ済み）}",
    "head": "{ブランチ名}",
    "base": "{ベースブランチ名}"
  }' \
  "http://{gitbucket-host}:{port}/api/v3/repos/{owner}/{repo}/pulls"
```

例:
```
curl -s -X POST -u "{user}:{password}" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "docs: 完了時にコミットとPR作成を必須ルールとして追加",
    "body": "## 概要\nチケット駆動開発の完了フローにコミットとPR作成を必須ルールとして追加。\n\n## 変更内容\n- AGENTS.md に完了時ルール#12を追加\n- 完了チェックリストにコミットとPR作成のチェック項目を追加\n\n## テスト\n- [ ] Redmine チケットで作業完了後にコミット・PRが自動作成される\n\n## 備考\n- リモートリポジトリ: http://{gitbucket-host}:8080/{owner}/ticket-driven\n- Refs: #2",
    "head": "main",
    "base": "main"
  }' \
  "http://{gitbucket-host}:8080/api/v3/repos/{owner}/ticket-driven/pulls"
```

### 4. 確認

#### GitHubの場合
```
gh pr view --json number,title,url
```

#### GitBucketの場合
```
curl -s -u "{ユーザー名}:{パスワード}" \
  "http://{gitbucket-host}:{port}/api/v3/repos/{owner}/{repo}/pulls"
```

## PRテンプレート

### 新機能

```
## 概要
{機能の概要}

## 背景
{なぜ必要か}

## 実装内容
- {実装1}
- {実装2}

## 完了条件
- [ ] {条件1}
- [ ] {条件2}

## テスト
- [ ] 単体テスト
- [ ] 結合テスト
```

### 修正

```
## 概要
{修正内容}

## 原因
{バグの原因}

## 修正内容
{どのように修正したか}

## 影響確認
- [ ] 関連箇所の動作確認
- [ ] 回帰テスト
```

## GitBucket API 一覧

| メソッド | パス | 用途 |
|---------|------|------|
| GET | `/api/v3/repos/{owner}/{repo}/pulls` | PR一覧 |
| POST | `/api/v3/repos/{owner}/{repo}/pulls` | PR作成 |
| GET | `/api/v3/repos/{owner}/{repo}/pulls/{number}` | PR取得 |

## gh コマンド一覧（GitHub用）

| コマンド | 用途 |
|---------|------|
| `gh pr create` | PR作成 |
| `gh pr view` | PR確認 |
| `gh pr merge` | PRマージ |
| `gh pr checks` | チェック確認 |
| `gh pr list` | PR一覧 |
