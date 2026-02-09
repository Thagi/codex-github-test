# Codex 開発推進ベストプラクティス（2026-02）

更新日: 2026-02-09

## 1. 要点

1. Codex運用の中核は `AGENTS.md` + `SKILL.md` + GitHub Actions の組み合わせ。
2. `SKILLS.md` ではなく、正式なスキル定義ファイルは `SKILL.md`（単数）。
3. 24/7実行が必要な自動化は Codex App の常駐運用より GitHub Actions 運用が安定。
4. GitHub Issues起点の自動修正は実装可能（ラベル/コメントトリガ + Codex実行 + PR作成）。
5. MCPは「必要なサーバだけ」「最小権限」で有効化する。

## 2. AGENTS.md 運用

`AGENTS.md` には「毎回守るルール」だけを書く。

- ブランチ規約（例: `codex/*`）
- PR粒度（1PR=1目的）
- CI必須化
- 自動マージ条件
- 危険操作の確認ゲート
- レビュー観点（セキュリティ、認証、リリース）

詳細手順や長いテンプレートは `docs/` や `SKILL.md` に分離する。

## 3. Skills 運用

### 3.1 構造

- 推奨配置: `/.agents/skills/<skill-name>/SKILL.md`
- トリガ精度を上げるため、frontmatter の `description` に「いつ使うか」を明確に書く。
- スキルは1責務に分割し、短く保つ。

### 3.2 設計の基本

1. SKILL本体は短く、具体的な手順を命令形で書く。
2. 反復処理はスクリプト化し、スキルから呼ぶ。
3. 機密情報はスキルに埋め込まず、Secretsで参照する。

## 4. MCP サーバ利用

### 4.1 基本方針

1. まず公式Docs系MCPから導入する。
2. プロジェクトごとに必要なMCPだけ有効化する。
3. `enabled_tools` / `disabled_tools` で利用可能ツールを絞る。
4. トークンは環境変数で参照し、設定ファイルに直書きしない。

### 4.2 設定例（Codex）

例ファイル: `/Users/thagi/work/repositories/codex-github-test/.codex/config.toml.example`

## 5. GitHub Issue 自動修正の実装パターン

### 5.1 推奨トリガ

1. Issueに `codex:fix` ラベル付与
2. Issueコメント `/codex fix`
3. `workflow_dispatch` 手動再実行

### 5.2 推奨フロー

1. Issue本文を取得してランタイムプロンプト生成
2. Codexを `workspace-write` + `drop-sudo` で実行
3. 変更がある場合のみPR作成
4. 実行結果をIssueへ自動コメント

### 5.3 セキュリティ要件

1. Issue本文は untrusted input として扱う
2. ワークフロー権限を最小化する
3. 直接 `main` へpushしない
4. 必須シークレット未設定時は即失敗

## 6. 一度やればよい設定 / 毎回必要な設定

### 6.1 一度やればよい（同一端末・同一アカウント）

- `gh` インストール
- `gh auth login`
- Codex AppとGitHub連携

### 6.2 リポジトリごとに必要

- GitHub Actions workflow定義
- branch protection
- 必要なSecrets登録
- リポジトリ固有の `AGENTS.md` / Skill調整

## 7. 参考（一次情報）

- OpenAI Codex AGENTS.md: https://developers.openai.com/codex/guides/agents-md
- OpenAI Codex Skills: https://developers.openai.com/codex/skills
- OpenAI Codex MCP: https://developers.openai.com/codex/mcp
- OpenAI Codex GitHub Action: https://developers.openai.com/codex/github-action
- OpenAI Codex + GitHub連携: https://developers.openai.com/codex/integrations/github
- GitHub Actions イベント: https://docs.github.com/actions/learn-github-actions/events-that-trigger-workflows
- GitHub `GITHUB_TOKEN` セキュリティ: https://docs.github.com/actions/concepts/security/github_token
- GitHub MCP Server (公式): https://github.com/github/github-mcp-server
