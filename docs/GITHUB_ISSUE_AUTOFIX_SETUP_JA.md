# GitHub Issue 自動修正セットアップ（Codex）

更新日: 2026-02-09

## 1. 前提

- リポジトリに `/.github/workflows/codex-issue-fix.yml` があること
- GitHub Actions が有効であること
- Codex実行用シークレットが登録されていること

## 2. 必須シークレット

リポジトリに以下を設定:

- `OPENAI_API_KEY`

設定コマンド例:

```bash
gh secret set OPENAI_API_KEY --body "<your-openai-api-key>"
```

## 3. 実行トリガ

次のいずれかで起動:

1. Issueに `codex:fix` ラベルを付与
2. Issueコメントに `/codex fix` を投稿
3. Actionsの `workflow_dispatch` で `issue_number` を指定して手動起動

## 4. 実行結果

ワークフローは次を自動実施:

1. Issue情報を取得してCodex用プロンプトを組み立て
2. Codexで修正を実行
3. 差分があればPRを自動作成
4. 実行結果（Run URL / PR URL / 要約）をIssueへコメント

## 5. 運用上の注意

1. Issue本文は信頼せず、untrusted inputとして扱う
2. `main` 直pushはさせず、PR経由に固定する
3. branch protectionでCI必須にする
4. Actions権限は最小化する

