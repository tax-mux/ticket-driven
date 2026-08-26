# マージ

## feature → main

```
git checkout main
git merge feature/{名前}
```

## 衝突解決

1. 衝突ファイルを確認: `git status`
2. 各ファイルを開いて解決
3. 解決後: `git add {ファイル}`
4. コミット: `git commit`
