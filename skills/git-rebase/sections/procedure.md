# リベース手順

## リベースの基本

### mainにリベース

```
git checkout {ブランチ名}
git rebase main
```

### 特定コミットからリベース

```
git rebase {ベースコミット}
```

## interactiveリベース

### 直近3コミットを編集

```
git rebase -i HEAD~3
```

### 操作一覧

| 操作 | 意味 |
|------|------|
| pick | そのまま |
| reword | メッセージ変更 |
| edit | 停止して編集 |
| squash | 前のコミットと結合 |
| fixup | 前のコミットと結合（メッセージ破棄） |
| drop | 削除 |

## 衝突解決

1. 衝突ファイルを確認: `git status`
2. 各ファイルを開いて解決
3. 解決後: `git add {ファイル}`
4. 継続: `git rebase --continue`
5. キャンセル: `git rebase --abort`
