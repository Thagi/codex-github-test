# mobile-autonomous-template (test)

新規モバイル開発プロジェクトを開始するときにコピーして使う雛形です。

## 含まれるもの

- `AGENTS.md`（Codex運用ルール）
- `/.github/workflows/mobile-ci.yml`（CI）
- `/.github/workflows/mobile-cd-build.yml`（build-only CD）
- `/.github/workflows/codex-issue-fix.yml`（Issue起点の自動修正）
- `/.github/codex/prompts/fix-issue.md`（Issue自動修正プロンプト）
- `/.agents/skills/issue-fix-automation`（再利用Skill）
- `/.codex/config.toml.example`（MCP設定例）
- `/scripts/*.sh`（CI/CD実行スクリプト）
- `/docs/*.md`（セットアップ手順）

## 使い方（概要）

1. このディレクトリを新規リポジトリへコピー
2. `scripts/post_copy_check.sh` を実行
3. 対象スタックをscaffold（Flutter / React Native / Android Native / iOS Native）
4. `scripts/ci.sh` が通るように調整
5. `OPENAI_API_KEY` をGitHub Secretへ登録
6. `codex:fix` ラベルを作成

詳細は `docs/SETUP_JA.md` を参照。
