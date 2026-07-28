---
name: git-commit
description: Gitコミット。コミットメッセージ生成、ステージング、hooks対応。
---
# Gitコミット

Gitにコミットする手順。

## 着手前チェックリスト

- [ ] `git status` で変更内容を確認
- [ ] `git diff` で差分を確認
- [ ] `git log -5` で直近のコミットメッセージを確認（メッセージ形式に合わせる）
- [ ] シークレットが含まれていないか確認

## コミット手順

```
git status
git diff
git log -5 --oneline
```

### 1. staging

```
git add {ファイルパス}
# または git add .
```

### 2. コミットメッセージ生成

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

### 3. コミット

```
git commit -m "$(cat <<'EOF'
{コミットメッセージ}

EOF
)"
```

### 4. 確認

```
git status
git log -1
```

## Git Safety Protocol

- **git configを更新しない**
- **破壊的コマンドを禁止**: push --force, hard reset等（明示的指示がない限り）
- **--no-verifyを禁止**: hooksをバイパスしない
- **amendの制限**:
  - HEADコミットは本セッションで生成したもののみ
  - リモートにpushされていないこと
  - pre-commit hookで失敗した場合は新規コミット

## コミットタイプ一覧

| type | 用途 |
|------|------|
| feat | 新機能 |
| fix | バグ修正 |
| docs | ドキュメント |
| style | コード形式（コメント、空白等） |
| refactor | リファクタリング |
| test | テスト |
| chore | 維持作業 |
