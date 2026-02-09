# codex-github-test

Python package sample with CI/CD automation on GitHub Actions.

## Workflows

- `Python CI`: runs on push and pull request to `main`/`master`.
- `Python CD`: deploys after `Python CI` succeeds on `main`, and supports manual dispatch.

## Deploy Setup (PyPI/TestPyPI)

1. Create API tokens:
   - PyPI token (production)
   - TestPyPI token (staging)
2. Set repository secrets in GitHub:
   - `PYPI_API_TOKEN`
   - `TEST_PYPI_API_TOKEN`
3. Deployment is executed by `/scripts/deploy.sh`:
   - `DEPLOY_TARGET=staging` uploads to TestPyPI.
   - `DEPLOY_TARGET=production` uploads to PyPI.

## Package

- Package name: `codex-github-test-thagi`
- Source: `/src/codex_github_test`
- Version: `0.1.0`
