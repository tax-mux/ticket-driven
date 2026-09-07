---
name: ticket-driven
description: チケット駆動開発の全体ワークフロー。Redmineチケットを起点に開発タスクを駆動する。
---
# チケット駆動開発 (Ticket-Driven Development)

Redmine チケットを起点に開発タスクを駆動する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

**パス解釈:** 本スキル内の `sections/*.md` は **スキル正本**（例: `~/.agents/skills/ticket-driven/sections/`）への参照。**作業リポジトリ内のパスではない。** `.ticket-driven/` 等のローカルディレクトリは **作らない・読まない**。

## ジャーナルとは（誤解防止）

| 用語 | 正体 | 読み方 |
|------|------|--------|
| **ジャーナル**（作業ログ） | Redmine チケットの **`journals`**（各 `notes` の履歴） | `redmine_issues` **get** + `include: ["journals"]`（Tier は `ops.md`） |
| **`sections/journal.md`** | 上記 `notes` の **書式・タイミングの説明書**（スキル内 Markdown） | 形式が分からないときだけ開く。**作業ログの実体ではない** |

- **禁止:** `read` / `read_file` / `glob` でプロジェクト内からジャーナルを探す（`.ticket-driven/`、`journal.md`、`.redmine/` 等）
- **禁止:** MemPalace だけを正本にして Redmine journals を読まない（drawer は **補助**。再開・分割証拠は Redmine 優先）
- **禁止:** ジャーナル未取得のまま「情報不足」とユーザーに丸投げ（先に Redmine get）

## チケットの役割

- ユーザーが渡すのは **絡まった依頼** でよい（渡し方の問題ではない）
- エージェントが **計画をチケットに書く**（refine / 分割 / 委任パック / ジャーナル）
- **正本**: description（DoD）+ **Redmine journals**（作業ログ）。**非正本**: チャット、圧縮サマリ、セッション履歴、MemPalace 要約単体
- 受け取ったあと **方針を建て直す** のはエージェントの仕事。再開時は作業ログを見て **リプラン要否を判定**（毎回ゼロから組み直す必要はない）→ `resume.md`

## HARD GATE（最優先）

次を満たすまで **コード変更・コミット・PR をしない**。

1. `issue_id` がある（ユーザー指定 or `ticket-create` で作成）
2. **要件が充足**され、完了条件が **検証可能**（中身は `ticket-refine`）
3. **分割の証拠**がある（自己申告だけでは不可）:
   - 親ジャーナルに `分割: ...`（子 ID 列挙）がある、**または**
   - 親ジャーナルに `分割不要: {理由}` がある（理由フォーマットはスキル `sections/journal.md`。機械的必須分割に該当する親では **禁止**）
   - **証拠にならないもの（禁止の代替）**: 子の `parent_issue_id` 紐付けだけ／チャット上の「分割した」／ワークスペース内のローカルメモファイル。これらがあっても親ジャーナルの `分割:` / `分割不要:` が無ければ **着手禁止**。書き方は `ops.md`（notes 最短例）
4. 着手ジャーナル（**実装チケット＝子がある場合は必ず子**。親への着手・親 In Progress は禁止）。**委任パック必須**（`delegate-pack.md`）
5. **Redmine フィールド更新**（下記「Redmine 更新」）。`notes` だけ書いて **status / done_ratio を触らない** のは未着手・未完了扱い

**分割判定はスキップしない。** refine 直後に必ず `ticket-split` を開き、子作成か `分割不要:` ノートまでやってから着手する。

**再開**は日常フローの **入口に分岐1つ** 足すだけ（出口は同じ）。作業ログを読み **リプラン要否** を決める。必要なら refine／分割で計画を書き直してから着手。不要なら作業単位を確認して実装続行。把握したらすぐ edit しない（`resume.md`）。

**自動精緻化**: 確認せず `ticket-refine`。DoD があっても命題未展開・品質観点未反映・範囲/失敗時/テスト不足・分割候補未記載なら更新。充足なら更新スキップ。読み分けは refine の目録。

**自動分割**: refine 直後に `ticket-split` 二段判定。必須トリガ A–F（DoD≥4 / 独立塊≥2 / 中心成果≥2 / 中心パス≥4 / 同居禁止 等。事前に数える指標のみ）に当たれば **必ず子を作る**。分割するなら親の切り出し（プレースホルダ禁止）。子は合格ライン（DoD 1〜3 等）。**障害・エラーは現象確認→調査→解決**（`ticket-create` の `bug-flow.md` / split の `policy.md`）。分割後の順は `after-split.md`。

refine 後も DoD 不能／外部情報必須 → 質問は最大3つ。例外: 質問・設計のみ／読み取りのみ／「チケット不要」明示。

起動例: `#42 着手` / `#42 レビューして` / `#42 再開`

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| ジャーナル **書式**（`分割:` / `着手:` 等の文言。実体は Redmine get） | スキル `sections/journal.md` |
| 子（または単一票）の着手直前・委任の境界 | `sections/delegate-pack.md` |
| 子をサブエージェントへ委任する（共通・並列禁止） | `sections/delegate-subagent.md` |
| 上記 + OpenCode | `sections/delegate-subagent-opencode.md` |
| 上記 + Hermes | `sections/delegate-subagent-hermes.md` |
| Resolved 直前のクローズ監査 | `sections/close-audit.md` |
| 条件別の重い手順の自動判定表 | `sections/dispatch.md` |
| 途中停止・モデル切替・状況把握して再開 | `sections/resume.md` |
| テスト計画の確認・実行 | `sections/test-plan.md` |
| UI・画面・見た目の変更 | `sections/ui-verify.md` |
| 実装中の予防／実装後のリファクタ検討 | `sections/refactor.md` |
| 子チケットがある・分割直後 | `sections/after-split.md` |
| MCP・ステータス・操作例・コミット/PR | `sections/ops.md` |

スキルトリガー表は `skills/navigation-protocol.md`。

## 共通ステップ（新規・再開で同じ出口）

新規は A から、再開は **A の前に `resume.md` の B（リプラン要否）** を挟む。それ以外同じ。

```
A. get(#N) + 計画をチケットに書く
   → ticket-refine（足りていればスキップ）
   → ticket-split → 親に `分割:` または `分割不要:`（Redmine notes。書式は sections/journal.md）

B. 着手
   → `着手:` + 委任パック + **status_id=進行中**（子があるなら **子のみ**）→ delegate-pack.md / ops.md

C. 実装
   → test-plan 確認 → 実装（refactor.md 予防）→ DoD 区切りで **done_ratio** → テスト実行 + DoD 検証

D. 完了
   → close-audit.md → 完了ノート + **status_id=Resolved** + **done_ratio=100** → コミット/PR は依頼時のみ（ops.md）
   → 子 Resolved 直後は **親 done_ratio** を更新（after-split.md）
```

## Redmine 更新（省略禁止）

**チャット報告や `notes` だけでは進捗にならない。** `redmine_api_request` でフィールドを更新する（操作例は `ops.md`）。

| タイミング | 対象票 | 必須 |
|------------|--------|------|
| B 着手 | 実装チケット | `notes`（`着手:` + 委任パック）+ **`status_id`=進行中** |
| C 途中 | 同左 | 主要 DoD 完了ごとに **`done_ratio`**（0→25→50→75。詰まり報告以外の連投は不要） |
| D 完了 | 同左 | `notes`（`完了:` + クローズ監査）+ **`status_id`=Resolved** + **`done_ratio`=100** |
| 子が Resolved | **親** | **`done_ratio`** = 完了子数 / 子総数（%）。全子後に親 Resolved |

- New のまま実装しない / 0% のまま Resolved しない
- 着手〜完了中の status・done_ratio は **`ticket-driven` 内で更新**（`ticket-update` に逃がさない）

OpenCode/Hermes で子を委任する場合: B のあと `delegate-subagent.md`（**1 子ずつ直列**）。

### 再開だけの追加（`resume.md`）

```
再開要求
 → ジャーナル（**Redmine get**）+ 差分で現状把握（edit 禁止）
 → リプラン要否を判定
     ├ 不要 → `再開検討:` / `計画継続:` を1行 → B 以降（共通ステップ）
     └ 必要 → refine / split で計画を書き直し → `リプラン:` → B 以降
 → 長停止・圧縮後・モデル切替は新セッション推奨
```

詳細は `resume.md`。条件分岐は `dispatch.md`。ジャーナル **書式** はスキル `sections/journal.md`。
