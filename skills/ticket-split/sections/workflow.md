# 分割ワークフロー（作成・関連・親更新）

## 1. 分割計画

```
## 分割案（機能構成 → セッション完走）

### 機能構成 A: {名前}
#### 子1: {セッション単位のタイトル}
- 範囲: やる / やらない（この子だけ）
- 完了条件: （1〜3個。検証可能）
- 影響範囲: ファイル・モジュール
- テスト範囲: この子の完了条件に対応。自動/手動/目視
- 依存: なし（先行）

#### 子2: …
- 依存: 子1
```

## 2. 子チケット作成

```json
{
  "method": "POST",
  "path": "/issues.json",
  "body": {
    "issue": {
      "project_id": "{プロジェクトID}",
      "parent_issue_id": "{ID}",
      "tracker_id": 2,
      "subject": "{セッション単位のタイトル}",
      "description": "{説明}",
      "priority_id": 2
    }
  }
}
```
ツール: `redmine_api_request`（`redmine_issues` に create は無い）

`description` は `templates.md` を **埋めた本文**。プレースホルダや見出しだけの子は作らない。親と **同じプロジェクト** に作る。プロジェクトを跨がない。

## 3. 関連付け

子同士の順序依存は `precedes` / `blocks` 等で明示（単なる `relates` だけにしない）:

```json
{
  "method": "POST",
  "path": "/issues/{先行ID}/relations.json",
  "body": {
    "relation": {
      "issue_to_id": "{CHILD_ID}",
      "relation_type": "precedes"
    }
  }
}
```
ツール: `redmine_api_request`

## 4. 親チケット更新

```json
{
  "method": "PUT",
  "path": "/issues/{親ID}.json",
  "body": {
    "issue": {
      "notes": "チケットを分割（機能構成→セッション完走）:\n- #{子1ID}: {タイトル1}\n- #{子2ID}: {タイトル2}"
    }
  }
}
```

分割しない場合（**ノート省略禁止**。機械的必須トリガに当たる親ではこの枝を使わない）:

```json
{
  "method": "PUT",
  "path": "/issues/{親ID}.json",
  "body": {
    "issue": {
      "notes": "分割不要: DoD={n}個 / 中心ファイル目安={少数|1成果} / 理由={1セッションで着手〜Resolvedまで収まる根拠}"
    }
  }
}
```

`分割:` / `分割不要:` のどちらかが親ジャーナルに無い限り、呼び出し元は着手してはならない（`ticket-driven` HARD GATE）。

## 5. 親チケットの進捗

子チケットの完了率に応じて進捗率を更新:

```json
{
  "method": "PUT",
  "path": "/issues/{親ID}.json",
  "body": { "issue": { "done_ratio": 33 } }
}
```

全子 Resolved 後に親を Resolved する（`ticket-driven` 側。`after-split.md`）。
