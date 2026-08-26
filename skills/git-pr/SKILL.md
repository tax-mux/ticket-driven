---
name: git-pr
description: PR作成。gh cliまたはGitBucket API対応。diff確認、タイトル/本文生成。
---
# Pull Request作成

gh cliまたはGitBucket APIを使ってPRを作成する手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| GitHub（gh）で PR を作る／確認する | `sections/github-gh.md` |
| GitBucket API で PR を作る／確認する | `sections/gitbucket-api.md` |
| 種別別の PR 本文テンプレが必要 | `sections/templates.md` |

## 概要

### 着手前チェックリスト

- [ ] `git status` でコミット済みか確認
- [ ] `git branch` で現在ブランチを確認
- [ ] `git log` でコミット履歴を確認
- [ ] `git diff main...HEAD` で変更範囲を確認

### 手順（骨格）

1. 状態確認: `git status` / `git diff main...HEAD` / `git log main..HEAD --oneline`
2. プッシュ: `git push -u origin HEAD`
3. PR作成 — GitHub なら `github-gh.md`、GitBucket なら `gitbucket-api.md`
4. 確認 — 同上の節

ユーザー依頼時、またはチケット完了条件に含まれるときだけ行う。PR 本文に `Refs: #N` を入れる。
