# Redmine MCP・ステータス・操作例

## ジャーナル（作業ログ）の読み方

- **正本:** チケット get 応答の **`journals`** 配列（各要素の `notes`）
- **取得:** `redmine_issues` action `get` + `include: ["journals"]`（再開・分割証拠は Tier 3。`ops.md`）
- **書き込み:** `redmine_api_request` PUT の `issue.notes`（+ 必要なら `status_id` / `done_ratio`）
- **禁止:** 作業リポジトリ内の `.ticket-driven/`、`journal.md`、`read_file` でジャーナルを探す
- **補助:** MemPalace drawer は Redmine の代わりにしない（不足分の get を先）

## Redmine MCP 呼び出しの約束（この環境）

- `redmine_issues` は **`list` / `get` のみ**。作成・更新・ノートは **`redmine_api_request`**
- `issue` / `relation` / `body` / `query` は **オブジェクト**。JSON 文字列にしない
- `issue_id` は文字列（`"42"`）。誤って `id` キーを使わない
- `get` の `include` は **文字列配列**（`["journals","attachments"]`）
- list のフィルタは **`query` オブジェクト**へ
- **一覧に description は無い**（件名で選び、本文は get）。`GET /issues.json` / `GET /projects.json` も同様
- `redmine_api_request` の `path` は **相対パスのみ**（`/issues/42.json`）。フル URL は禁止
- 認証トークンは渡さない。MCP 非接続時は `./tools/redmine_helper.sh`（`REDMINE_API_KEY` 必須）
- **添付（画像等）**: MCP では不可。`./tools/redmine_helper.sh attach <id> <file> [notes]` を使う
- HTTP 不通時は Redmine / DB コンテナ起動を先に試す

## 取得 Tier（コンテキスト節約）

Redmine get は **必要最小の `include`** に留める。一覧は常に Tier 0。

| Tier | 操作 | `include` | 使う場面 |
|------|------|-----------|----------|
| 0 | `list` | なし | 探索・重複チェック・Open 票の洗い出し |
| 1 | `get` | なし（description のみ） | 新規着手・精緻化・子 1 枚の実装（委任パック済み） |
| 2 | `get` | `["children"]` | 分割判定・子の特定・親ハブの構造確認 |
| 3 | `get` | `["journals"]` または `["journals","children"]` | 再開・クローズ監査・分割証拠（`分割:` / `分割不要:`）の確認 |

**運用ルール**

- 原則 **下位 Tier から**試し、情報が足りなければ 1 段だけ上げる
- **親ハブに実装着手しない**。親は Tier 2 まで。分割証拠が journal に無いときだけ Tier 3
- **委任パック＋description** で DoD・検証・依存が読めるなら、再開も Tier 1 でよい（詳細は `resume.md`）
- MemPalace drawer に要約があれば **先に drawer**、Redmine は不足分だけ get
- **同一セッション**で同票を Tier 3 で再 get しない（既に読んだ journals を再利用）

Tier 1 の例:

```json
{ "action": "get", "issue_id": "42" }
```

Tier 3 の例:

```json
{ "action": "get", "issue_id": "42", "include": ["journals", "children"] }
```

ツール: `redmine_issues`

## ステータス（本環境の目安）

必ず `GET /issue_statuses.json` で確認すること。

| 意味 | よくある ID |
|------|-------------|
| 新規 | 1 |
| 進行中 | 2 |
| 解決 | 3 |

標準遷移: `New → In Progress → Resolved → Closed`（Feedback 経由あり）

## 最小操作例

取得: 上記 **取得 Tier** に従う（迷ったら Tier 1 から）。

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
