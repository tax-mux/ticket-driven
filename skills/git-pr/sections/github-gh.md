# GitHub（gh cli）

## PR作成

```
gh pr create --title "{タイトル}" --body "$(cat <<'EOF'
## 概要
<1-3行で概要>

## 変更内容
- {変更1}
- {変更2}

## テスト
- [ ] {テスト1}
- [ ] {テスト2}

## 備考
{補足情報}

EOF
)"
```

## 確認

```
gh pr view --json number,title,url
```

## gh コマンド一覧

| コマンド | 用途 |
|---------|------|
| `gh pr create` | PR作成 |
| `gh pr view` | PR確認 |
| `gh pr merge` | PRマージ |
| `gh pr checks` | チェック確認 |
| `gh pr list` | PR一覧 |
