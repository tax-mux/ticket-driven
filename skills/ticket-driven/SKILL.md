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
3. **分割判定が済んでいる**（機能構成→セッション完走、または分割不要）
4. 着手ジャーナル 1 行（実装チケット＝子がある場合は **子**）

**自動精緻化**: 確認せず `ticket-refine`。DoD があっても命題未展開・品質観点未反映・範囲/失敗時/テスト不足なら更新。充足なら更新スキップ。読み分けは refine の目録。

**自動分割**: refine 直後に `ticket-split` 二段判定。分割するなら親の切り出しで子作成（プレースホルダ禁止）。1セッション完走サイズ。分割後の順は `after-split.md`。

refine 後も DoD 不能／外部情報必須 → 質問は最大3つ。例外: 質問・設計のみ／読み取りのみ／「チケット不要」明示。

起動例: `#42 着手` / `#42 レビューして`

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| ジャーナル文言・タイミング | `sections/journal.md` |
| 条件別の重い手順の自動判定表 | `sections/dispatch.md` |
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
 → ticket-split（機能構成→セッション完走）
     ├ 分割 → 子ごとに着手〜完了。親は done_ratio / 最終 Resolved
     └ 分割不要 → 当該チケットで着手〜完了
 → 着手ノート + In Progress
 → テスト確認（漏れ拾い）→ test-plan.md
 → 実装（予防リファクタ）→ refactor.md
 → テスト実行 + DoD 検証 → test-plan.md（UI なら ui-verify.md）
 → code-refactor 事後検討 → refactor.md
 → 完了ノート + Resolved（DoD [x]、URL 欠け埋め。テンプレ差し替え禁止）
 → コミット/PR は依頼時のみ → ops.md
```

条件分岐の詳細表は `dispatch.md`。ジャーナル例は `journal.md`。
