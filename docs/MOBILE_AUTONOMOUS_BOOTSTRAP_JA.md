# スマホアプリ開発 自律ブートストラップ手順（Codex用）

更新日: 2026-02-09

## 1. 目的

Codexがスマホアプリ開発開始時に、最小の確認で実装とGitHub運用を自動的に前進させるための標準手順。

## 2. 基本方針

- 開発フローは `実装 -> 検証 -> PR -> CI -> 自動マージ` を標準とする。
- CDはデフォルトで `build-only`（artifact出力まで）。
- ストア公開（App Store / Google Play）は明示依頼時のみ実行。

## 3. 初回セットアップ（リポジトリ単位）

1. リポジトリ作成と接続確認
   - `git remote -v`
   - `gh auth status -h github.com`
2. ブランチ保護確認（`main`）
   - 必須チェックにCI workflowを設定
3. ワークフロー作成
   - `/.github/workflows/*`
4. README/Docs整備
   - ローカル実行手順
   - CI/CD手順
   - 失敗時の復旧手順

## 4. スタック別最小テンプレート

## 4.1 Flutter

- Scaffold: `flutter create .`
- CI:
  - `flutter analyze`
  - `flutter test`
  - `flutter build apk --debug`（必要に応じて）
- CD(build-only):
  - `flutter build apk --release`
  - artifact upload

## 4.2 React Native

- Scaffold: React Native CLI / Expo のどちらかを固定
- CI:
  - `npm run lint`（または同等）
  - `npm test`
  - `npm run typecheck`
- CD(build-only):
  - Android/iOSのビルド成果物をartifact化

## 4.3 iOS Native

- CI:
  - `xcodebuild test`
  - `xcodebuild build`
- CD(build-only):
  - `.app` / `.ipa`（署名要件に応じる）をartifact化

## 4.4 Android Native

- CI:
  - `./gradlew lint test`
  - `./gradlew assembleDebug`
- CD(build-only):
  - `./gradlew assembleRelease`
  - `.apk` / `.aab` をartifact化

## 5. PR運用ルール

1. `codex/*` ブランチを使用
2. 1PR = 1目的
3. CI成功後は `gh pr merge --auto` を基本運用
4. 失敗時はログ解析して同一PR内で修正継続

## 6. ストア配布を後から追加する場合

- App Store/Play配布は次をSecretsとして追加後に有効化:
  - iOS: 証明書、Provisioning Profile、App Store Connect API Key
  - Android: Keystore、Play Console Service Account
- 追加時は build-only ワークフローを壊さず段階的に導入する。

## 7. Codexへの依頼テンプレート（ユーザー向け）

以下のように依頼すると、Codexが自律的に進めやすい。

1. 「Flutterで新規スマホアプリを開始。雛形、CI、build-only CD、PR作成まで自動で進めて」
2. 「React Native向けにlint/test/typecheckのCIを作り、main保護前提で運用可能にして」
3. 「iOS/Androidの成果物をartifact化するCDを追加し、失敗時は修正PRまで継続して」

