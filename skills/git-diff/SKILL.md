---
name: git-diff
description: diff確認・レビュー支援。
---
# diff確認・レビュー

Git diffの確認とレビュー支援。

## diffの確認

### 未ステージ差分

```
git diff
```

### staging済み差分

```
git diff --staged
```

### mainとの差分

```
git diff main...HEAD
```

### ファイル指定

```
git diff {ファイルパス}
```

### コミット間差分

```
git diff {コミットA}..{コミットB}
```

## diffの出力形式

```
git diff --stat          # ファイル統計
git diff --name-only     # ファイル名のみ
git diff -w              # 空白無視
git diff --color-words   # 変更箇所をカラー
```

## レビューチェックリスト

- [ ] 意図した変更か
- [ ] シークレットが含まれていないか
- [ ] 不要な変更がないか
- [ ] テストが更新されているか
- [ ] ドキュメントが更新されているか
- [ ] パフォーマンス影響がないか

## 変更箇所の確認

```
# 行数付き
git diff --line-number

# 変更前・後
git diff --word-diff
```
