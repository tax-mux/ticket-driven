---
name: git-log
description: ログ検索・コミット履歴取得。
---
# gitログ検索

コミット履歴の取得と検索。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 基本・条件指定・詳細表示のコマンド例 | `sections/commands.md` |
| オプション早見表だけ欲しい | `sections/options.md` |

## 概要

よく使う入口:

```
git log -10
git log --oneline -10
git log --oneline --graph --all
```

日付・作者・ファイル・grep は `commands.md`。オプション表は `options.md`。
