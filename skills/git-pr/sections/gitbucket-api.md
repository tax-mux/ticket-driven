# GitBucket API

## diffの生成

```
git diff main...HEAD
```

## PR本文の生成

diffの内容を基に本文を生成:

- 変更したファイル一覧
- 各ファイルの変更内容
- テスト範囲

## PR作成

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
    "body": "## 概要\nチケット駆動開発の完了フローにコミットとPR作成を必須ルールとして追加。\n\n## 変更内容\n- AGENTS.md に完了時ルール#12を追加\n- 完了チェックリストにコミットとPR作成のチェック項目を追加\n\n## テスト\n- [ ] Redmine チケットで作業完了後にコミット・PRが自動作成される\n\n## 備考\n- リモートリポジトリ: http://{gitbucket-host}:8080/{owner}/ticket-driven\n- Refs: #N",
    "head": "main",
    "base": "main"
  }' \
  "http://{gitbucket-host}:8080/api/v3/repos/{owner}/ticket-driven/pulls"
```

## 確認

```
curl -s -u "{ユーザー名}:{パスワード}" \
  "http://{gitbucket-host}:{port}/api/v3/repos/{owner}/{repo}/pulls"
```

## API 一覧

| メソッド | パス | 用途 |
|---------|------|------|
| GET | `/api/v3/repos/{owner}/{repo}/pulls` | PR一覧 |
| POST | `/api/v3/repos/{owner}/{repo}/pulls` | PR作成 |
| GET | `/api/v3/repos/{owner}/{repo}/pulls/{number}` | PR取得 |
