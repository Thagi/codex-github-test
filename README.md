# codex-github-test

Python package sample with CI/CD automation on GitHub Actions.

## Workflows

- `Python CI`: runs on push and pull request to `main`/`master`.
- `Python CD`: runs after `Python CI` succeeds on `main`, builds distribution artifacts, and uploads `dist/*` as workflow artifacts.
- `Codex Issue Fix`: runs on `codex:fix` issue label or `/codex fix` issue comment, then asks Codex to generate a fix PR.

## CD Behavior (Build Only)

- `/scripts/deploy.sh` builds package artifacts (`sdist`/`wheel`) and validates them with `twine check`.
- GitHub Actions uploads built files from `dist/*` to the workflow run artifacts.
- No PyPI/TestPyPI secrets are required.

## Package

- Package name: `codex-github-test-thagi`
- Source: `/src/codex_github_test`
- Version: `0.1.0`

## Autonomous Development Docs

- Agent operation rules: `/AGENTS.md`
- Mobile bootstrap playbook: `/docs/MOBILE_AUTONOMOUS_BOOTSTRAP_JA.md`
- Session summary: `/docs/CODEX_GITHUB_AUTONOMOUS_DEV_GUIDE_JA.md`
- 2026-02 best practices: `/docs/CODEX_BEST_PRACTICES_2026-02_JA.md`
- Issue autofix setup: `/docs/GITHUB_ISSUE_AUTOFIX_SETUP_JA.md`
- MCP config sample: `/.codex/config.toml.example`
- Issue automation skill: `/.agents/skills/issue-fix-automation/SKILL.md`

## Reusable Starter Template

- Test template directory for new mobile projects:
  - `/template-mobile-autonomous-test`
