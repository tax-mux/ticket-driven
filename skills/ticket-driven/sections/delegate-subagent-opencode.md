# サブエージェント委任 — OpenCode

共通ポリシーは `delegate-subagent.md`。本ファイルは **呼び出し口だけ**。

## 計画の正本

- **Redmine チケットの journals + description** が計画（`redmine_issues` get。ローカルファイルではない）
- 再開・委任前: `resume.md` — Redmine journals で **リプラン要否** を判定してから `task`
- 委任 prompt には **委任パック全文**（Redmine から取得した内容）を載せる

## ツール

- 親: `build`（primary）
- 委任: **`task`** ツール
- 既定の子: `subagent_type: "general"`（実装・編集が必要なら general。調査のみなら `explore`）

## 直列（必須）

- **1 回の `task` = 子 1 枚**
- 前の `task` が終わるまで次を呼ばない
- 複数 `task` の同時起動・バッチ相当は **禁止**（ローカル LLM 1 プロセス前提）

## 呼び出し例

```text
task(
  subagent_type: "general",
  description: "子 #456 実装",
  prompt: """
Redmine 子チケット #456 を完走せよ。親 #100 には触るな。

委任パック:
- 作業単位: #456
- DoD: （子 description / ジャーナルの委任パックをそのまま）
- 影響範囲: …
- 検証: …
- 依存: …
- 禁止: 親実装 / 他子侵食 / 並列委任

手順:
1. redmine_issues get #456（Tier 1。再開・分割証拠なら include journals）
2. 委任パックに従い実装・テスト
3. クローズ監査後、完了ノート + Resolved
4. 親・他子は更新しない（done_ratio は親セッション側）
"""
)
```

## 注意

- カスタム `mode: subagent` エージェントがある場合のみ、それに差し替えてよい
- `task` が失敗したら共通ポリシーの **新セッション** フォールバック
- 親は結果要約を受けたら次の未完了子を **1 枚だけ** 選んで繰り返す
