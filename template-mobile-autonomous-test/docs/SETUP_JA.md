# セットアップ手順（テンプレート利用）

## 1. テンプレートをコピー

このディレクトリを新規リポジトリのルートにコピーする。

## 2. 必須準備

1. GitHub Secrets:
   - `OPENAI_API_KEY`
2. GitHub Label:
   - `codex:fix`

コマンド例:

```bash
gh secret set OPENAI_API_KEY --body "<your-openai-api-key>"
gh label create "codex:fix" --color "B60205" --description "Trigger Codex issue auto-fix workflow"
```

## 3. スタックをscaffold

以下のいずれか:

1. Flutter
2. React Native
3. Android Native
4. iOS Native（このテンプレートのCI/CDはLinux前提なのでiOS部分は追加調整が必要）

## 4. CI/CDの確認

1. `scripts/ci.sh`
2. `scripts/cd_build.sh`
3. `/.github/workflows/mobile-ci.yml`
4. `/.github/workflows/mobile-cd-build.yml`

## 5. Issue自動修正の確認

1. Issueを作成
2. `codex:fix` ラベルを付ける
3. またはIssueに `/codex fix` をコメント
4. `Codex Issue Fix` ワークフロー実行結果を確認
