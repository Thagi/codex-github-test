#!/usr/bin/env bash
set -euo pipefail

TARGET="${DEPLOY_TARGET:-production}"

if [[ ! -f pyproject.toml && ! -f setup.py ]]; then
  echo "pyproject.toml or setup.py is required for package deployment."
  exit 1
fi

python -m pip install --upgrade pip
python -m pip install --upgrade build twine

rm -rf dist
python -m build
python -m twine check dist/*

case "$TARGET" in
  staging)
    : "${TEST_PYPI_API_TOKEN:?TEST_PYPI_API_TOKEN is required for staging deploy}"
    python -m twine upload \
      --non-interactive \
      --skip-existing \
      --repository-url https://test.pypi.org/legacy/ \
      --username __token__ \
      --password "$TEST_PYPI_API_TOKEN" \
      dist/*
    ;;
  production)
    : "${PYPI_API_TOKEN:?PYPI_API_TOKEN is required for production deploy}"
    python -m twine upload \
      --non-interactive \
      --skip-existing \
      --username __token__ \
      --password "$PYPI_API_TOKEN" \
      dist/*
    ;;
  *)
    echo "Unsupported DEPLOY_TARGET: $TARGET"
    echo "Use DEPLOY_TARGET=staging or DEPLOY_TARGET=production."
    exit 1
    ;;
esac
