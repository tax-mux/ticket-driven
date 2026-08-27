# 運用・MCP・登録先プロジェクト

## 登録先プロジェクト（誤り防止）

精緻化対象チケットの **所属プロジェクトを変えたり、別プロジェクトへ新規を切ったりしない**。

- アプリ固有（例: brave-search-mcp）→ そのプロジェクトのチケットを更新
- スキル／運用ルール本体（ticket-driven）→ `{your-redmine-project}`
- ワークスペースのカレントだけでプロジェクトを推測しない。`get` の `project` を見る

リモート未確保で実装不能なら、コメントに「リポジトリ未作成」→ Feedback 等で保留（毎回必須検査ではない。実装チケットで remote が要るときだけ）。

## get / update

取得（`redmine_issues`）: **取得 Tier** は `ticket-driven` の `sections/ops.md` に従う。精緻化の初回は **Tier 1**（description のみ）。分割証拠や journal 履歴の確認が必要なときだけ Tier 3。

```json
{ "action": "get", "issue_id": "{ID}" }
```

説明更新 + ノート（`redmine_api_request`。`redmine_issues` に update/add_note は無い）:

```json
{
  "method": "PUT",
  "path": "/issues/{ID}.json",
  "body": {
    "issue": {
      "description": "{精緻化内容}",
      "notes": "精緻化: {要約}"
    }
  }
}
```

- `issue` / `body` は **オブジェクト**。JSON 文字列にしない
- `issue_id` は文字列。誤って `id` キーを使わない
- 認証トークンは渡さない
