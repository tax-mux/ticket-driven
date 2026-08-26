# Redmine MCP・ステータス・操作例

## Redmine MCP 呼び出しの約束（この環境）

- `redmine_issues` は **`list` / `get` のみ**。作成・更新・ノートは **`redmine_api_request`**
- `issue` / `relation` / `body` / `query` は **オブジェクト**。JSON 文字列にしない
- `issue_id` は文字列（`"42"`）。誤って `id` キーを使わない
- `get` の `include` は **文字列配列**（`["journals","attachments"]`）
- list のフィルタは **`query` オブジェクト**へ
- `redmine_api_request` の `path` は **相対パスのみ**（`/issues/42.json`）。フル URL は禁止
- 認証トークンは渡さない。MCP 非接続時は `./tools/redmine_helper.sh`（`REDMINE_API_KEY` 必須）
- **添付（画像等）**: MCP では不可。`./tools/redmine_helper.sh attach <id> <file> [notes]` を使う
- HTTP 不通時は Redmine / DB コンテナ起動を先に試す

## ステータス（本環境の目安）

必ず `GET /issue_statuses.json` で確認すること。

| 意味 | よくある ID |
|------|-------------|
| 新規 | 1 |
| 進行中 | 2 |
| 解決 | 3 |

標準遷移: `New → In Progress → Resolved → Closed`（Feedback 経由あり）

## 最小操作例

取得:

```json
{ "action": "get", "issue_id": "42", "include": ["journals", "children"] }
```

ツール: `redmine_issues`

着手（ノート + 進行中）:

```json
{
  "method": "PUT",
  "path": "/issues/42.json",
  "body": { "issue": { "notes": "着手: APIリトライ", "status_id": 2 } }
}
```

完了:

```json
{
  "method": "PUT",
  "path": "/issues/42.json",
  "body": { "issue": { "notes": "完了: リトライ実装 — cargo test 成功", "status_id": 3 } }
}
```

ツール: `redmine_api_request`

## 完了条件の書き方

悪い例: 「品質を高める」「堅牢にする」  
良い例: 「`scripts/ci.sh` が通る」「`brave_search.rs` に 429 リトライが入り最大3回」

## コミットと PR

ユーザーが明示したとき、またはチケット完了条件に含まれるときだけ行う。  
安全手順は Cursor ユーザールール／`git-*` スキルに従う。PR 本文に `Refs: #N` を入れる（子の場合は子 ID。親にも触れたら親も列挙可）。

## Redmine 主要ツール

| ツール | 用途 |
|---|---|
| `redmine_issues` | list / get のみ |
| `redmine_api_request` | 作成・更新・ノート・statuses・relations 等の REST |
| `redmine_current_user` | 認証ユーザー確認 |
| `redmine_list_profiles` | プロファイル名一覧 |
