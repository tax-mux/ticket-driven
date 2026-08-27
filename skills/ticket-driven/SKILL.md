---
name: ticket-driven
description: チケット駆動開発の全体ワークフロー。Redmineチケットを起点に開発タスクを駆動する。
---
# チケット駆動開発 (Ticket-Driven Development)

Redmine チケットを起点に開発タスクを駆動する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## HARD GATE（最優先）

次を満たすまで **コード変更・コミット・PR をしない**。

1. `issue_id` がある（ユーザー指定 or `ticket-create` で作成）
2. **要件が充足**され、完了条件が **検証可能**（中身は `ticket-refine`）
3. **分割の証拠**がある（自己申告だけでは不可）:
   - 親ジャーナルに `分割: ...`（子 ID 列挙）がある、**または**
   - 親ジャーナルに `分割不要: {理由}` がある（理由フォーマットは `journal.md`。機械的必須分割に該当する親では **禁止**）
4. 着手ジャーナル（**実装チケット＝子がある場合は必ず子**。親への着手・親 In Progress は禁止）。**委任パック必須**（`delegate-pack.md`）

**分割判定はスキップしない。** refine 直後に必ず `ticket-split` を開き、子作成か `分割不要:` ノートまでやってから着手する。

**再開も同じ。** 途中停止・モデル切替・「状況把握して再開」のあとでも、現状把握の直後に **サイズ判定→分割／再分割** を挟む。把握したらすぐ実装しない（詳細は `resume.md`）。

**自動精緻化**: 確認せず `ticket-refine`。DoD があっても命題未展開・品質観点未反映・範囲/失敗時/テスト不足・分割候補未記載なら更新。充足なら更新スキップ。読み分けは refine の目録。

**自動分割**: refine 直後に `ticket-split` 二段判定。必須トリガ A–F（DoD≥4 / 独立塊≥2 / 中心成果≥2 / 中心パス≥4 / 同居禁止 等。事前に数える指標のみ）に当たれば **必ず子を作る**。分割するなら親の切り出し（プレースホルダ禁止）。子は合格ライン（DoD 1〜3 等）。**障害・エラーは現象確認→調査→解決**（`ticket-create` の `bug-flow.md` / split の `policy.md`）。分割後の順は `after-split.md`。

refine 後も DoD 不能／外部情報必須 → 質問は最大3つ。例外: 質問・設計のみ／読み取りのみ／「チケット不要」明示。

起動例: `#42 着手` / `#42 レビューして` / `#42 再開`

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| ジャーナル文言・タイミング（`分割:` / `分割不要:` / 再開検討 / 完了監査 含む） | `sections/journal.md` |
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

## 日常最小フロー

大きい儀式はしない。許可を求めず、ブロックがなければ最後まで進める。

```
get(#N)
 → ticket-refine（足りていれば更新スキップ）
 → ticket-split（機能構成→セッション完走）※必読・判定必須
     ├ 分割 → 親に `分割:` ノート → 子ごとに着手〜完了（**直列**。並列禁止）。親は done_ratio / 最終 Resolved
     │         OpenCode/Hermes なら子をサブエージェント委任可 → delegate-subagent.md
     └ 分割不要可 → 親に `分割不要:` ノート（省略禁止）→ 当該チケットで着手〜完了
 → 着手ノート（**委任パック必須**）+ In Progress（子があるなら子のみ）→ delegate-pack.md
 → テスト確認（漏れ拾い）→ test-plan.md
 → 実装（予防リファクタ）→ refactor.md
 → テスト実行 + DoD 検証 → test-plan.md（UI なら ui-verify.md）
 → code-refactor 事後検討 → refactor.md
 → **クローズ監査** → close-audit.md（未充足なら Resolved 禁止）
 → 完了ノート + Resolved（DoD [x]、監査結果、URL 欠け埋め。テンプレ差し替え禁止）
 → コミット/PR は依頼時のみ → ops.md
```

### 再開フロー（要約）

```
再開要求 → 現状把握（未完 DoD・差分）※まだ edit しない
 → サイズ判定 → ticket-split（分割／再分割／分割不要ノート）
 → 細かい子（または分割不要の単一票）だけ着手
 → 可能なら新セッション・モデルは子単位で固定
 → 以降は日常フロー
```

詳細は `resume.md`。条件分岐は `dispatch.md`。ジャーナル例は `journal.md`。
