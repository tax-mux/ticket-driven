---
name: git-diff
description: diff確認・レビュー支援。
---
# diff確認・レビュー

Git diffの確認とレビュー支援。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| diff コマンド・出力形式 | `sections/commands.md` |
| レビューチェックリスト | `sections/review-checklist.md` |

## 概要

よく使う入口:

```
git diff
git diff --staged
git diff main...HEAD
```

詳細コマンドは `commands.md`。レビュー観点は `review-checklist.md`。
