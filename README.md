# codex-github-test

Python package sample with CI/CD automation on GitHub Actions.

## Workflows

- `Python CI`: runs on push and pull request to `main`/`master`.
- `Python CD`: runs after `Python CI` succeeds on `main`, builds distribution artifacts, and uploads `dist/*` as workflow artifacts.

## CD Behavior (Build Only)

- `/scripts/deploy.sh` builds package artifacts (`sdist`/`wheel`) and validates them with `twine check`.
- GitHub Actions uploads built files from `dist/*` to the workflow run artifacts.
- No PyPI/TestPyPI secrets are required.

## Package

- Package name: `codex-github-test-thagi`
- Source: `/src/codex_github_test`
- Version: `0.1.0`
