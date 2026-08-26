# navigation-protocol（スキル選択の索引）

依頼に対して **どのスキルを開くか** を決めるための総目録。  
詳細手順・節パス・HARD GATE 本文はここに書かない。選んだらその `SKILL.md` の目録に従う。

## 使い方

1. スキルが分かっている → このファイルを飛ばして当該 `SKILL.md` だけ開く
2. 迷う → 下の「いつ → スキル」で1つ選ぶ → その `SKILL.md` だけ開く
3. スキル内の詳細が必要 → そのスキルの目録が指す `sections/*` だけ開く
4. **複数スキルの SKILL.md をまとめて読まない**

`.git` がある作業の実装・変更は、原則 `ticket-driven` から入る（例外は各スキル／INIT の「チケット不要」）。

## いつ → スキル

| いつ（迷いどころ） | 開くスキル | パス |
|--------------------|------------|------|
| `#N 着手` / 実装して / 完走して / チケット駆動で進める / `#N 再開` / 状況把握して再開 | ticket-driven | `skills/ticket-driven/SKILL.md` |
| 要件が薄い・命題を膨らませる・精緻化 | ticket-refine | `skills/ticket-refine/SKILL.md` |
| 分割する？ / 子チケット / セッション完走サイズ | ticket-split | `skills/ticket-split/SKILL.md` |
| 新規起票 | ticket-create | `skills/ticket-create/SKILL.md` |
| 進捗・説明・ステータス・ノート更新 | ticket-update | `skills/ticket-update/SKILL.md` |
| 一覧・フィルタ・ページ送り | ticket-list | `skills/ticket-list/SKILL.md` |
| New/進行中/Feedback など状態別の補助 | ticket-status | `skills/ticket-status/SKILL.md` |
| precedes / blocks など関連付け | ticket-relation | `skills/ticket-relation/SKILL.md` |
| 600行超・ネスト深・予防リファクタ | code-refactor | `skills/code-refactor/SKILL.md` |
| コミットして | git-commit | `skills/git-commit/SKILL.md` |
| PR作って | git-pr | `skills/git-pr/SKILL.md` |
| ブランチ作成・切替・マージ | git-branch | `skills/git-branch/SKILL.md` |
| rebase | git-rebase | `skills/git-rebase/SKILL.md` |
| diff / レビュー観点 | git-diff | `skills/git-diff/SKILL.md` |
| ログ検索・履歴 | git-log | `skills/git-log/SKILL.md` |

### よくある迷い

| 迷い | 答え |
|------|------|
| 精緻化と分割、どっち？ | 先に `ticket-refine`、直後に `ticket-driven` 経由で `ticket-split`（日常は `ticket-driven` 1本で両方走る） |
| 再開はすぐ実装？ | しない。`ticket-driven` の `resume.md`：把握→サイズ→分割／再分割→子のみ |
| create と driven？ | 起票だけなら `ticket-create`。実装まで含むなら `ticket-driven`（必要なら create を呼ぶ） |
| update と driven？ | ノートやフィールドだけなら `ticket-update`。着手〜完了フローなら `ticket-driven` |
| git-* を先に？ | チケット駆動中のコミット/PRはユーザー依頼時。手順は各 git-*。流れの親は `ticket-driven` |

## スキルマッピング（INPUT → PATH）

正本はすべて `skills/<name>/SKILL.md`。フラットな `skills/*.md` は置かない。  
MemPalace / 脊髄反射用のローマ字キー。上の「いつ → スキル」と同一パスを指す。

| INPUT | PATH |
|---|---|
| ticketdriven | skills/ticket-driven/SKILL.md |
| ticketcreate | skills/ticket-create/SKILL.md |
| ticketstatus | skills/ticket-status/SKILL.md |
| ticketupdate | skills/ticket-update/SKILL.md |
| ticketlist | skills/ticket-list/SKILL.md |
| ticketrelation | skills/ticket-relation/SKILL.md |
| ticketrefine | skills/ticket-refine/SKILL.md |
| ticketsplit | skills/ticket-split/SKILL.md |
| gitcommit | skills/git-commit/SKILL.md |
| gitpr | skills/git-pr/SKILL.md |
| gitbranch | skills/git-branch/SKILL.md |
| gitrebase | skills/git-rebase/SKILL.md |
| gitdiff | skills/git-diff/SKILL.md |
| gitlog | skills/git-log/SKILL.md |
| coderefactor | skills/code-refactor/SKILL.md |
