# Git Safety Protocol と type一覧

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
