# UI 編集の検証（Playwright＋スクショ添付）

画面・CSS・レイアウト・フロントの見た目／操作に触れる変更では、通常のテスト計画に加え **必須**:

1. **Playwright** で対象画面を開き、チケットの意図（DoD）どおりかを確認する  
   - プロジェクトに Playwright がある → それを使う  
   - 無い → `npx playwright` 等で最小スクリプト／codegen でも可（インストール自動化はしない）
2. **スクリーンショット**を撮る（意図が分かる1枚以上。前後比較があるなら before/after）
3. スクショを **チケットに添付**する（下記）。添付なしで UI チケットを Resolved にしない
4. 完了ノートに `UI確認: Playwright OK — 添付 {ファイル名}` を1行

**添付できないとき（例外・必須）:** 環境障害・秘密画面・ツール不能など、どうしても添付できない場合だけ、完了／進行ノートに次を **理由つきで明記**する（理由なしの省略は不可）。

```
UI証拠なし: {具体的な理由} — 代替: {コードパス／ログ／Playwright テキスト結果など}
```

評価側（`ticket-evaluate`）は添付空かつこの行が無い → **不合格**。行があり理由が具体的なら **条件付き合格** の候補（推測の満額合格にはしない）。

テスト範囲の書き方例:

```
## テスト範囲
- [ ] Playwright: 一覧に検索結果が出る
- [ ] スクショをチケットに添付する
- 手順: `npx playwright test ...` または一時スクリプトで page.goto → expect → screenshot
```

## スクショのチケット添付（MCP では不可）

`redmine_api_request` / `redmine_issues` は **JSON のみ**。`Content-Type: application/octet-stream` のバイナリ upload はできない。

使う:

```bash
# リポジトリ正本
./tools/redmine_helper.sh attach <issue_id> ./path/to/shot.png 'UI確認: {何を見た}'
```

内部は Redmine 標準の2段（`POST /uploads.json` → `PUT /issues/{id}.json` の `uploads`）。  
`REDMINE_API_KEY` が必要。MCP 接続中でも **添付だけは helper（または同等の curl）** を使う。
