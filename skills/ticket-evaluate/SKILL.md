---
name: ticket-evaluate
description: >-
  チケットの DoD・範囲・検証計画に照らして実装を点検し、評価を Redmine ジャーナルへ追記する。
  Use when the user asks to evaluate/review/inspect implementation for a ticket
  (#N 評価 / #N 実装を点検 / #N レビューして as evaluation), when a ticket is in レビュー status,
  or after Resolved when a second pass is needed.
---
# チケット実装評価 (Ticket Evaluate)

チケットを正本に、実装差分・関連ファイル・テストを点検し、**評価を Redmine `journals`（`notes`）へ追記**する。

**常時読むのは本ファイルだけ。** 本文は目録の条件に合うファイルだけ開く。`sections/` をまとめて読まない。

## 位置づけ

| 対比 | 違い |
|------|------|
| 本スキル | **点検・評価**。チャット報告で終わらせず、必ず対象票に `評価:` ノートを書く |
| `close-audit.md`（ticket-driven） | **実装者が Resolved 直前に自己監査**する手順。評価スキルの代替ではない |
| `git-diff` | diff 観点の補助。チケット DoD 照合・ジャーナル追記は本スキル |

## レビュー状態との関係（必須）

- **原則**: 票の status が **レビュー**（本環境目安 id=7。`redmine_metadata` で確認）のときに評価する
- **進行中のまま解決**する経路は ticket-driven で禁止。評価もその前提に合わせる
- **`評価:` は `notes` のみ**。`status_id` / `done_ratio` / `estimated_hours` は **触らない**（合格でも自分で Resolved にしない）
- **不合格**: ノートに不合格と差し戻し指示を書く。実装側が **レビュー→進行中** に戻す（評価側は status 変更禁止）
- **合格 / 条件付き合格（ブロッカーなし）**: 実装側がクローズ監査のうえ **レビュー→解決** する
- 「フィードバック」status は人の差し戻し用。LLM 評価には使わない
- Resolved 済み票の再評価は従来どおり可（プロセス注意として書いてよい）

## HARD GATE との関係

- **コード変更・コミット・PR はしない**（読み取り＋テスト実行＋ Redmine `notes` のみ）
- 評価の結果として修正が必要でも、**勝手に直さない**。指摘をジャーナルに残し、修正はユーザー指示または別セッションの `ticket-driven` 着手で行う
- `status_id` / `done_ratio` / `estimated_hours` は **触らない**（評価は状態を動かさない）
- 親ハブに実装評価を書かない。**実装チケット（子、または分割不要の単一票）**へ書く

## 目録

| 開く条件 | 読むファイル |
|----------|----------------|
| 手順の詳細・点検順 | `sections/workflow.md` |
| DoD・範囲・**コード品質（注意点レーン）**・**UIトンマナ／ユーザビリティ**の点検観点 | `sections/criteria.md` |
| ジャーナル `評価:` の書式・例 | `sections/journal-format.md` |
| 画面票でヒューリスティック詳細が必要 | スキル **`ui-critique`** の `sections/heuristics.md`（本スキル外） |
| UI スクショ／Playwright 手順 | `ticket-driven` の `sections/ui-verify.md` |

## 概要（最短）

1. `redmine_issues` **get** `#N`（`include: ["journals","children","relations","attachments"]`）
2. description の **完了条件・範囲・テスト範囲** と、着手／完了ジャーナルから **実装パス** を特定。**画面票は先に attachments（スクショ等）の有無を確認**（無ければ関連票も。規則は `criteria.md`）
3. 該当ソース・テストを読み、可能ならチケット記載のテストを実行
4. DoD 対応表＋品質（Q1–Q5）＋UI 証拠＋注意点をまとめ、`notes` のみで `評価:` を追記（書式は `journal-format.md`）
5. ユーザーへ要約を返し、ジャーナル追記済みであることを明示

**画面票:** DoD／テスト範囲に画面到達・手動 UI があるのにチケット上の画面証拠が無い → **不合格**（API／コード PASS だけでは上げない）。

起動例: `#N 評価して` / `#N 実装を点検して` / `#N の実装をレビューして（評価）`

MCP: **`mcp-redmine_redmine_issues`** `action: "update"` + `notes` のみ（`ticket-update` に逃がして status を変えない）。
