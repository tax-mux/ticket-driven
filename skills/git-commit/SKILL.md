---
name: git-commit
description: Gitコミット。コミットメッセージ生成、ステージング、hooks対応。
---
# Gitコミット

Gitにコミットする手順。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| ステージ〜コミット〜確認の手順・メッセージ規則 | `sections/procedure.md` |
| Safety Protocol・amend制限・type一覧 | `sections/safety.md` |

## 概要

### 着手前チェックリスト

- [ ] `git status` で変更内容を確認
- [ ] `git diff` で差分を確認
- [ ] `git log -5` で直近のコミットメッセージを確認（メッセージ形式に合わせる）
- [ ] シークレットが含まれていないか確認

ユーザー明示依頼時のみ。詳細手順は `procedure.md`。安全制約は `safety.md`。
