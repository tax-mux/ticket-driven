# 注意事項とプッシュ

## リベース後のプッシュ

force pushが必要（注意）:

```
git push --force-with-lease origin {ブランチ名}
```

## 注意事項

- **publicブランチのリベースは禁止**: 共有済みのコミットはrebaseしない
- **--force-with-lease**: `--force` より安全（他人のpushを拒否）
- **rebase前には必ずbackup**: `git branch backup-{名前}`
