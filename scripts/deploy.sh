#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f pyproject.toml && ! -f setup.py ]]; then
  echo "pyproject.toml or setup.py is required for package build."
  exit 1
fi

python -m pip install --upgrade pip
python -m pip install --upgrade build twine

rm -rf dist
python -m build
python -m twine check dist/*
ls -lh dist
