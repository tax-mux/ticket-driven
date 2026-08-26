---
name: git-branch
description: ブランチ操作。分岐、マージ、名付け規則。
---
# ブランチ操作

Gitブランチの操作手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 作成・切替・一覧・削除のコマンド | `sections/commands.md` |
| マージ・衝突解決 | `sections/merge.md` |
| PR前チェック | `sections/pr-checklist.md` |

## 概要

### ブランチ名規則

```
{種別}/{短縮タイトル}
```

| 種別 | プレフィックス |
|------|---------------|
| 新機能 | feature/ |
| 修正 | fix/ |
| 実験 | exp/ |
| リファクタ | refactor/ |
| テスト | test/ |

例: `feature/user-list`, `fix/login-timeout`

作成・切替は `commands.md`。マージは `merge.md`。
