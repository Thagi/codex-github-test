#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

rm -rf artifacts
mkdir -p artifacts

echo "[CD] Build-only artifact generation started"

if [[ -f "pubspec.yaml" ]]; then
  echo "[CD] Flutter detected"
  command -v flutter >/dev/null || { echo "[CD] flutter command not found"; exit 1; }
  flutter pub get

  if [[ -d "android" ]]; then
    flutter build apk --debug
    find build/app/outputs -type f -name "*.apk" -exec cp {} artifacts/ \;
  else
    echo "[CD] android directory not found for Flutter build." > artifacts/flutter-build-note.txt
  fi
elif [[ -f "package.json" ]]; then
  echo "[CD] Node/React Native detected"
  command -v node >/dev/null || { echo "[CD] node command not found"; exit 1; }

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

  if [[ -f "android/gradlew" ]]; then
    (cd android && chmod +x gradlew && ./gradlew assembleDebug)
    find android/app/build/outputs -type f \( -name "*.apk" -o -name "*.aab" \) -exec cp {} artifacts/ \;
  else
    echo "[CD] android/gradlew not found. Add RN/Android build step as needed." > artifacts/react-native-build-note.txt
  fi
elif [[ -f "gradlew" ]]; then
  echo "[CD] Android Gradle detected"
  chmod +x gradlew
  ./gradlew assembleDebug
  find app/build/outputs -type f \( -name "*.apk" -o -name "*.aab" \) -exec cp {} artifacts/ \;
else
  echo "[CD] No supported stack detected. Add project scaffold before running CD." > artifacts/no-stack-note.txt
fi

if ! find artifacts -type f | grep -q .; then
  echo "[CD] No artifacts generated. Check stack-specific build commands." > artifacts/empty-artifacts-note.txt
fi

echo "[CD] Artifacts:"
ls -lah artifacts
