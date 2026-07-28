---
name: git-branch
description: ブランチ操作。分岐、マージ、名付け規則。
---
# ブランチ操作

Gitブランチの操作手順。

## ブランチ名規則

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

## ブランチ作成

```
git checkout -b {ブランチ名}
```

## ブランチ切り替え

```
git checkout {ブランチ名}
```

## ブランチ一覧

```
git branch -a
```

## マージ

### feature → main

```
git checkout main
git merge feature/{名前}
```

### 衝突解決

1. 衝突ファイルを確認: `git status`
2. 各ファイルを開いて解決
3. 解決後: `git add {ファイル}`
4. コミット: `git commit`

## ブランチ削除

```
# ローカル
git branch -d {ブランチ名}

# リモート
git push origin --delete {ブランチ名}
```

## プルリクエスト時のチェックリスト

- [ ] mainにrebase済み
- [ ] コンフリクトなし
- [ ] テスト通過
- [ ] コミットメッセージ確認
