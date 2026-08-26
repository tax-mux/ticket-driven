# コミット手順

```
git status
git diff
git log -5 --oneline
```

## 1. staging

```
git add {ファイルパス}
# または git add .
```

## 2. コミットメッセージ生成

以下のルールでメッセージを作成:

- 形式: `{type}: {概要}`
- type: feat, fix, docs, style, refactor, test, chore
- 日本語で簡潔（1-2行）
- 「なぜ」を重視、「何を」を補足

例:

```
feat: ユーザー一覧画面の実装
fix: ログインセッションの有効期限修正
docs: AGENTS.mdにワークフロー追記
```

## 3. コミット

```
git commit -m "$(cat <<'EOF'
{コミットメッセージ}

EOF
)"
```

## 4. 確認

```
git status
git log -1
```
