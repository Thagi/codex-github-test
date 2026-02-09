# AGENTS.md

## Purpose

This repository defines operational instructions for Codex to autonomously drive smartphone app development with GitHub-based CI/CD.

## Scope

- Applies when the user asks to start or continue smartphone app development.
- Target stacks:
  - Flutter
  - React Native
  - iOS (native)
  - Android (native)

## Core Operating Rules For Codex

1. Default behavior:
   - Implement, test, commit, push, create PR, and enable auto-merge when CI is green.
2. Branching:
   - Use `codex/*` branch names.
3. PR policy:
   - One logical change per PR.
   - Keep PR title/body concise and explicit.
4. CI/CD policy:
   - CI is mandatory for every PR.
   - CD should default to build-only artifact generation unless user explicitly requests store deployment.
5. Safety gates:
   - Ask before destructive operations.
   - Ask before production/store release actions.

## Mobile Project Bootstrap Checklist (Execution Order)

When starting a new mobile project, Codex should execute the following in order:

1. Confirm target stack and app identifier/package naming.
2. Scaffold project skeleton for the selected stack.
3. Add CI workflow:
   - lint/static analysis
   - unit tests
   - build validation
4. Add CD workflow (build-only):
   - run after CI success on `main`
   - upload app build artifacts
5. Add project docs:
   - setup steps
   - local run/test/build commands
   - CI/CD behavior
6. Run local validation commands available in environment.
7. Create PR and enable auto-merge.
8. Verify GitHub Actions completion and report run links.

## Deployment Mode Defaults

- Default: build-only CD (no store publish, no production release).
- Optional (explicit user request required):
  - App Store / Google Play deployment.
  - Signing and distribution credentials setup.

## Required Outputs Per Task

For each mobile development task, Codex should provide:

1. Changed file list.
2. Executed validation commands and result summary.
3. PR URL.
4. Workflow run status (CI/CD).
5. Next concrete options.

## Reference

- Detailed playbook: `/Users/thagi/work/repositories/codex-github-test/docs/MOBILE_AUTONOMOUS_BOOTSTRAP_JA.md`
- Session summary doc: `/Users/thagi/work/repositories/codex-github-test/docs/CODEX_GITHUB_AUTONOMOUS_DEV_GUIDE_JA.md`
