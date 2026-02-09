#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[CHECK] Template post-copy verification"

required_files=(
  "AGENTS.md"
  ".github/workflows/mobile-ci.yml"
  ".github/workflows/mobile-cd-build.yml"
  ".github/workflows/codex-issue-fix.yml"
  ".github/codex/prompts/fix-issue.md"
  "scripts/ci.sh"
  "scripts/cd_build.sh"
)

for f in "${required_files[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "[CHECK] Missing required file: $f"
    exit 1
  fi
done

echo "[CHECK] Required files are present."
echo "[CHECK] Next steps:"
echo "  1) Set GitHub secret OPENAI_API_KEY"
echo "  2) Create label codex:fix"
echo "  3) Scaffold your target mobile stack"
echo "  4) Customize scripts/ci.sh and scripts/cd_build.sh as needed"
