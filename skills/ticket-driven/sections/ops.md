# Redmine MCP・ステータス・操作例

## ジャーナル（作業ログ）の読み方

- **正本:** チケット get 応答の **`journals`** 配列（各要素の `notes`）
- **取得:** `redmine_issues` action `get` + `include: ["journals"]`（再開・分割証拠は Tier 3）
- **書き込み:** `redmine_issues` `action: "update"` + `notes`（+ 必要なら `status_id` / `done_ratio`）。逃げ道として `redmine_api_request` PUT の `issue.notes` も可
- **禁止:** 作業リポジトリ内の `.ticket-driven/`、`journal.md`、`read_file` でジャーナルを探す
- **禁止:** 子の `parent_issue_id` 紐付けだけ／ローカルメモを分割証拠の代わりにする
- **補助:** MemPalace drawer は Redmine の代わりにしない（不足分の get を先）

## ジャーナル（notes）最短例 — 分割証拠・着手・完了

**「ノート用ツールが無い」は誤り。** 分割証拠・着手・完了はすべて Redmine の `notes` で書く。ローカルファイルや親子ツリーだけでは HARD GATE を満たさない（スキル `sections/journal.md`）。

分割証拠（親）:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "notes": "分割: 機能構成→セッション完走\n- #43: 子題名A\n- #44: 子題名B\n作業単位は子。親はハブ。"
}
```

分割不要（親・省略禁止）:

```json
{
  "action": "update",
  "issue_id": "{ID}",
  "notes": "分割不要: DoD=2個 / 中心ファイル目安=1成果 / 理由=単一スクリプト変更で1セッション完走"
}
```

着手（実装チケット＝子があるなら子）:

```json
{
  "action": "update",
  "issue_id": "{CHILD_ID}",
  "status_id": 2,
  "notes": "着手: {概要}\n\n委任パック:\n- 作業単位: #{CHILD_ID}\n- DoD: ...\n- 影響範囲: ...\n- 検証: ...\n- 依存: なし\n- 禁止: 親実装 / 他子侵食 / 範囲外メタ"
}
```

完了（**先に**必要なら `done_ratio`。順序は下記「done_ratio とステータス」）:

```json
{
  "action": "update",
  "issue_id": "{CHILD_ID}",
  "done_ratio": 100,
  "notes": "完了: {概要} — テスト: {結果}\nクローズ監査: DoD全[x]=yes / 検証一致=yes / 親実装なし=yes / 範囲内=yes / 調査のみでない=yes / ステータス実体=yes / done_ratio実体=yes"
}
```

その直後に解決（同じ update にまとめても可。まとめるなら `done_ratio` と `status_id: 3` を **同時**に送る）:

```json
{
  "action": "update",
  "issue_id": "{CHILD_ID}",
  "status_id": 3
}
```

ツール: `redmine_issues`。`add_note` action は無い。

## Redmine MCP 呼び出しの約束（この環境）

- `redmine_issues`: **`list` / `get` / `create` / `update`**（フラット引数）。ジャーナルは update の `notes`
- relations・特殊 REST だけ **`redmine_api_request`**
- `issue` / `relation` / `body` / `query` は **オブジェクト**。JSON 文字列にしない
- `issue_id` は文字列（`"42"`）。誤って `id` キーを使わない
- `get` の `include` は **文字列配列**（`["journals","attachments"]`）
- list のフィルタは **`query` オブジェクト**へ
- **一覧に description は無い**（件名で選び、本文は get）。`GET /issues.json` / `GET /projects.json` も同様
- `redmine_api_request` の `path` は **相対パスのみ**（`/issues/42.json`）。フル URL は禁止
- 認証トークンは渡さない。MCP 非接続時は `./tools/redmine_helper.sh`（`REDMINE_API_KEY` 必須）
- **添付（画像等）**: MCP では不可。`./tools/redmine_helper.sh attach <id> <file> [notes]` を使う
- HTTP 不通時は Redmine / DB コンテナ起動を先に試す
- update の ACK（`ok` / `null` 風）だけで成功としない。必要なら直後に `get` して status / done_ratio / journals を確認

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
{ "action": "get", "issue_id": "{ID}" }
```

Tier 3 の例:

```json
{ "action": "get", "issue_id": "{ID}", "include": ["journals", "children"] }
```

ツール: `redmine_issues`

## ステータス（本環境の目安）

必ず `GET /issue_statuses.json`（または `redmine_metadata` `kind: "issue_statuses"`）で確認すること。

| 意味 | よくある ID | エージェント通常経路 |
|------|-------------|----------------------|
| 新規 | 1 | 可 |
| 進行中 | 2 | 可 |
| 解決 | 3 | **完了はここまで** |
| 終了 | 5 | **使わない**（権限外・誤用多発。人が閉じる） |

標準遷移（エージェント）: `New → In Progress → Resolved`。Feedback 経由あり。

## done_ratio とステータス（順序必須）

Redmine は **解決(3) のあと `done_ratio` が凍結**することが多い。逆順（先に解決→後から rate）は失敗する。

**正しい順序（どちらか）**

1. Open（新規1 / 進行中2）のまま `done_ratio` を設定 → その後 `status_id: 3`
2. **1回の update** で `done_ratio` と `status_id: 3`（および完了 `notes`）を同時送信

**禁止**

- 解決(3) のあとに `done_ratio` だけ更新しようとすること
- エージェント通常経路で **終了(5)** にすること（権限外・親集計の誤解の元。閉じるのは人）
- update の ACK（`ok: true` / 空 body / null 風）だけで成功とすること → **直後に `get`** し、意図した `status.id` と `done_ratio` を確認。違えばプロファイル／権限を疑い、直るまで Resolved 扱いにしない

親ハブ: 子を Resolved にするたびに、親がまだ Open のうち親の `done_ratio` を更新する（`after-split.md`）。親を解決する直前も同様に rate→解決。

## 最小操作例（api_request 逃げ道）

通常は上記の `redmine_issues` update を使う。relations 等で `api_request` が必要なときの PUT 例:

```json
{
  "method": "PUT",
  "path": "/issues/42.json",
  "body": { "issue": { "notes": "着手: APIリトライ", "status_id": 2 } }
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
| `redmine_issues` | list / get / create / update（notes・status・done_ratio 含む） |
| `redmine_api_request` | relations 等の REST 逃げ道 |
| `redmine_current_user` | 認証ユーザー確認 |
| `redmine_list_profiles` | プロファイル名一覧 |
