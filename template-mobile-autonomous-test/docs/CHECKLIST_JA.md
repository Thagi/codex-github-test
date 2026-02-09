# 新規プロジェクト開始チェックリスト

## 基本

- [ ] `AGENTS.md` の内容をプロジェクト要件に合わせて更新
- [ ] `README.md` をプロジェクト名で更新
- [ ] ブランチ保護でCI必須化

## CI/CD

- [ ] `scripts/ci.sh` が対象スタックで成功
- [ ] `scripts/cd_build.sh` がartifactを生成
- [ ] `Mobile CI` と `Mobile CD Build` が成功

## Issue自動修正

- [ ] `OPENAI_API_KEY` 登録済み
- [ ] `codex:fix` ラベル作成済み
- [ ] `Codex Issue Fix` の試験実行完了

## 運用

- [ ] `codex/*` ブランチ運用
- [ ] 1PR=1目的を維持
- [ ] CI成功後に自動マージ
