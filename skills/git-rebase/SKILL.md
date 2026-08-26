---
name: git-rebase
description: リベース操作。衝突解決、interactiveリベース。
---
# リベース操作

Gitリベースの手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 基本リベース・interactive・衝突解決 | `sections/procedure.md` |
| force-with-lease・注意事項 | `sections/cautions.md` |

## 概要

```
git checkout {ブランチ名}
git rebase main
```

interactive・衝突は `procedure.md`。共有ブランチへの注意は `cautions.md`（**必読**）。
