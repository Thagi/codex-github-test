# Codex + GitHub 自律開発ガイド（今回の実施内容まとめ）

更新日: 2026-02-09

## 1. 目的

Codexが自律的に実装を進めつつ、GitHubで安全に管理するための運用を標準化する。

## 2. 今回実施した設定と結果

### 2.1 Codex App と GitHub 連携

- `chatgpt.com/codex` で GitHub を接続（ユーザー側で実施済み）。
- 対象リポジトリをCodexで操作可能な状態にした。

### 2.2 GitHub CLI (`gh`) の導入と認証

- インストール: `brew install gh`
- 認証: `gh auth login --hostname github.com --web --git-protocol https`
- 確認: `gh auth status -h github.com`

### 2.3 自律開発フローを実行

- `codex/*` ブランチで実装
- commit / push / PR作成をCodexで実施
- CI成功後の自動マージ（`gh pr merge --auto`）を実施

実際に作成・反映したもの:

- CIワークフロー: `/.github/workflows/python-ci.yml`
- CDワークフロー（最終形: ビルドのみ）: `/.github/workflows/python-cd.yml`
- ビルドスクリプト: `/scripts/deploy.sh`
- Python最小構成: `/pyproject.toml`, `/src/codex_github_test/__init__.py`
- 運用ドキュメント更新: `/README.md`

最終状態:

- `Python CI`: main push/PRで自動実行
- `Python CD`: CI成功後に自動実行、`dist/*` をartifactとして保存
- PyPIトークン不要（CDはビルド専用）

## 3. スマホアプリ開発にも適用できるか

適用可能。今回の本質は「言語」ではなく「運用モデル」。

- Codexで実装
- GitHubでブランチ/PR管理
- GitHub ActionsでCI/CD自動化
- 成功条件を満たしたら自動マージ

このモデルは Flutter / React Native / iOS(native) / Android(native) でも同様に使える。

## 4. 次回以降に不要な設定（再利用できるもの）

### 4.1 基本的に再不要（同一マシン/同一アカウント前提）

- `gh` のインストール
- `gh auth login`（トークン失効時を除く）
- Codex App のGitHub接続（連携が切れない限り）

### 4.2 リポジトリごとに必要

- CI/CDワークフロー追加（`/.github/workflows/*.yml`）
- Branch protection（必須チェック設定）
- Secrets設定（必要な配布先がある場合）

## 5. スマホアプリ開発時の推奨環境構築

## 5.1 共通（最初に必ず）

1. 新規GitHubリポジトリ作成
2. Codexでリポジトリ接続
3. `gh auth status` で認証確認
4. `main`保護ルール設定（CI必須）

## 5.2 技術スタック別の最小セット

### Flutter

1. `flutter create .`
2. CI: `flutter analyze`, `flutter test`
3. CD: `flutter build`（apk/ipa生成） + artifact保存

### React Native

1. Node + package manager（npm/pnpm/yarn）確定
2. CI: lint/test/typecheck
3. CD: Android/iOSビルド成果物をartifact化

### iOS/Android Native

1. iOS: Xcode build/test をCI化
2. Android: Gradle build/test をCI化
3. CD: 署名済みビルド生成、artifact化

## 5.3 実配布（App Store / Google Play）時の追加要件

実配布まで自動化する場合は、以下をSecretsとしてGitHub側に設定:

- iOS: 証明書、Provisioning Profile、App Store Connect APIキー
- Android: Keystore、Play Console service account key

注意:

- ここはプロジェクトごとに値が違うため、毎回設定が必要。
- 初回は「ビルドまで自動化」から始め、署名/配布は段階的に追加するのが安全。

## 6. 推奨運用ルール（Codex自律開発向け）

1. Codexは `codex/*` ブランチで作業する
2. 実装後は必ずテストを実行
3. PRを自動作成し、CI成功後に自動マージ
4. 破壊的変更・本番配布だけは明示確認
5. 失敗時はCodexがログを解析して修正PRまで継続

## 7. 次の具体アクション（スマホアプリ開始時）

1. スタック決定（Flutter / React Native / iOS / Android）
2. Codexに「雛形生成 + CI作成 + PR作成」を一括指示
3. CIが安定してからCD（まずartifact化）を追加
4. 最後に署名・ストア配布の自動化へ進める

