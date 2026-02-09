#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[CI] Detecting project stack..."

if [[ -f "pubspec.yaml" ]]; then
  echo "[CI] Flutter detected"
  command -v flutter >/dev/null || { echo "[CI] flutter command not found"; exit 1; }
  flutter pub get
  flutter analyze
  if [[ -d "test" ]]; then
    flutter test
  else
    echo "[CI] No Flutter test directory found. Skipping tests."
  fi
  exit 0
fi

if [[ -f "package.json" ]]; then
  echo "[CI] Node/React Native detected"
  command -v node >/dev/null || { echo "[CI] node command not found"; exit 1; }

  if [[ -f "package-lock.json" ]]; then
    npm ci
  elif [[ -f "pnpm-lock.yaml" ]]; then
    corepack enable
    pnpm install --frozen-lockfile
  elif [[ -f "yarn.lock" ]]; then
    corepack enable
    yarn install --frozen-lockfile
  else
    npm install
  fi

  has_script() {
    node -e "const p=require('./package.json'); process.exit(p.scripts && p.scripts['$1'] ? 0 : 1)"
  }

  if has_script lint; then
    npm run lint
  else
    echo "[CI] lint script not found. Skipping."
  fi

  if has_script typecheck; then
    npm run typecheck
  else
    echo "[CI] typecheck script not found. Skipping."
  fi

  if has_script test; then
    npm test
  else
    echo "[CI] test script not found. Skipping."
  fi
  exit 0
fi

if [[ -f "gradlew" ]]; then
  echo "[CI] Android Gradle project detected"
  chmod +x gradlew
  ./gradlew lint test assembleDebug
  exit 0
fi

echo "[CI] No supported stack detected."
echo "[CI] Scaffold Flutter / React Native / Android Native first, then rerun."
exit 1
