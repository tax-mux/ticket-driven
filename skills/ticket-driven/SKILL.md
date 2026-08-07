---
name: ticket-driven
description: チケット駆動開発の全体ワークフロー。Redmineチケットを起点に開発タスクを駆動する。
---
# チケット駆動開発 (Ticket-Driven Development)

Redmine チケットを起点に開発タスクを駆動する。

## HARD GATE（最優先）

次を満たすまで **コード変更・コミット・PR をしない**。

1. `issue_id` がある（ユーザー指定 or `ticket-create` で作成）
2. 完了条件が **検証可能**（例: `cargo test` 成功、特定ファイルに文言追加）
3. **分割判定が済んでいる**（機能構成単位で子チケット作成済み、または分割不要と判定済み）
4. 着手ジャーナル 1 行を書いた（実装するチケット＝子がある場合は **子** に書く）

**自動精緻化（人手を待たない）**: 着手・実装要求の時点で 2 が満たせない場合、ユーザーに確認せず **先に `ticket-refine` を実行**し、description を最小テンプレで更新してから次へ進む。短い説明でも完了条件が検証可能なら refine しない。

**自動分割（精緻化の直後）**: 精緻化が済んだ、または不要だった場合、実装の前に必ず **機能構成単位で `ticket-split` を判定・実行**する。分割後は **子チケットを作業単位**とし、親は進捗・統合のハブにする。単一の機能構成に収まるときだけ分割をスキップする。

refine 後も DoD が書けない／外部情報が必須 → 質問は **最大3つ**に絞る。それ以外は止めず完走する。

例外: 質問・設計のみ／読み取り調査のみ／ユーザーが「チケット不要」と明示。

起動フレーズ例: `#42 着手` / `#42 レビューして`

## 日常最小フロー（デフォルト・自動完走）

大きい儀式はしない。途中で許可を求めず、ブロック要因がなければ最後まで進める。

```
get(#N)
 → DoD 不能なら ticket-refine（自動）
 → 精緻化済 or 不要 → ticket-split（機能構成単位・確認不要）
     ├ 分割する → 子を作成し、子ごとに着手〜完了。親は done_ratio / 最終 Resolved
     └ 分割不要（単一機能構成）→ 当該チケットで着手〜完了
 → 着手ノート + In Progress
 → 実装 + 完了条件の検証
 → code-refactor 検討（触ったファイルのみ・確認不要）
 → 完了ノート + Resolved
 → ユーザーがコミット/PR を求めたらそのときだけ
```

| タイミング | ジャーナル |
|-----------|------------|
| 精緻化（自動時） | `精緻化: {要約}`（refine 側） |
| 分割 | `チケットを分割: ...`（split 側） |
| 着手 | `着手: {概要}`（実装チケット＝子優先） |
| リファクタ検討 | `リファクタ検討: {実施|見送り} — {要約}`（しきい値超過時のみ） |
| 完了 | `完了: {概要} — {検証結果}` |

進捗ジャーナルの連投は不要。詰まったときだけ追記。

### リファクタ検討（実装直後・自動）

DoD 検証のあと、**今回触ったソースだけ** `code-refactor` を検討する（リポジトリ全体スキャンはしない）。HARD GATE ではない。実施必須でもない。

| しきい値 | 動作 |
|---------|------|
| 600行超 | 機能構成単位のファイル分割を **検討** |
| ネスト5超 | 階層浅化を **検討** |

- 詳細手順・見送り基準は `code-refactor`（`skills/code-refactor/SKILL.md`）に従う
- 小さい変更なら同チケット内で実施してよい（振る舞いを変えない）
- 大きい／別責務ならフォロー or 子チケットにし、本チケットの Resolved は止めない
- しきい値未満ならジャーナル不要。超過時のみ上記テンプレで1行

## いつ重い手順を使うか（自動判定）

| 条件 | 動作 |
|------|------|
| 完了条件が検証不能／説明が空で DoD 不能 | **自動で** `ticket-refine`（確認不要） |
| 精緻化済、または精緻化不要（DoD 検証可能） | **自動で** `ticket-split` を判定。機能構成が2つ以上なら **子を作成してから**作業（確認不要） |
| すでに子チケットがある | 再分割しない。未完了の子を作業単位にする |
| 依存の明示が必要 | `ticket-relation`（`precedes` / `blocks` 等） |
| 実装で触ったファイルが 600行超 or ネスト5超 | **自動で** `code-refactor` を検討（確認不要。実施は任意） |

説明が短くても DoD が検証可能なら refine はしない。ただし **分割判定はスキップしない**（単一機能なら「分割不要」と判定して進む）。

### 分割後の作業順

1. 依存なし（先行）の子から着手する
2. 子を Resolved にするたびに親の `done_ratio` を更新する
3. すべての子が Resolved になったら親を Resolved にする（親に完了ノート）

## スキルトリガー

正本は `skills/<name>/SKILL.md`（詳細は `skills/navigation-protocol.md`）。

| 生発音（ローマ字） | パス |
|---|---|
| ticketcreate | skills/ticket-create/SKILL.md |
| ticketstatus | skills/ticket-status/SKILL.md |
| ticketupdate | skills/ticket-update/SKILL.md |
| ticketlist | skills/ticket-list/SKILL.md |
| ticketrelation | skills/ticket-relation/SKILL.md |
| ticketrefine | skills/ticket-refine/SKILL.md |
| ticketsplit | skills/ticket-split/SKILL.md |
| coderefactor | skills/code-refactor/SKILL.md |

## Redmine MCP 呼び出しの約束（この環境）

- `redmine_issues` は **`list` / `get` のみ**。作成・更新・ノートは **`redmine_api_request`**
- `issue` / `relation` / `body` / `query` は **オブジェクト**。JSON 文字列にしない
- `issue_id` は文字列（`"42"`）。誤って `id` キーを使わない
- `get` の `include` は **文字列配列**（`["journals","attachments"]`）
- list のフィルタは **`query` オブジェクト**へ
- 認証トークンは渡さない。MCP 非接続時は `./tools/redmine_helper.sh`（`REDMINE_API_KEY` 必須）
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
