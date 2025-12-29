# Process Standard: Issues, Pull Requests and Merges

This document defines a lightweight, practical standard for opening **Issues**, **Pull Requests (PRs)** and performing **Merges** in this repository. The goal is to reduce friction for contributors and ensure consistency for automations (labels, projects, changelog).

---

## 1) Issue pattern
- **Title**: `type: short summary` — where `type` can be `bug`, `feature`, `docs`, `chore`, `infra`.
  - Ex.: `bug: failure loading config on Python 3.11`
- **Minimum template** (use `.github/ISSUE_TEMPLATE/`):
  - Summary (one line)
  - Environment (version, OS, stack)
  - Steps to reproduce
  - Actual / expected result
  - Logs or relevant output
  - Priority / Severity (optional)

- **Initial labels**: assign `bug|enhancement|docs|help wanted|good first issue|priority:high` as appropriate.
- **Project / Milestone**: link the issue to a Project card and optionally a Milestone.
- **Assignee**: maintainer responsible (if known).

> Note: For security issues, use the `security.md` template and follow `SECURITY.md` (report privately if needed).

---

## 2) Pull Request pattern
- **PR title**: keep it short and descriptive. Recommended to use Conventional Commit style in the PR title (e.g., `feat(auth): add token rotation`).
- **PR body** (use `PULL_REQUEST_TEMPLATE.md`): always include
  - Short description of what was done
  - Why (motivation / context)
  - How to test (manual steps / scripts / commands)
  - Checklist (minimum):
    - [ ] Tests added/updated
    - [ ] Linter OK
    - [ ] Docs updated (if applicable)
    - [ ] CI passed
  - Related issue: `Closes #n` when the PR will close an issue
- **Review**:
  - Request at least one reviewer; `CODEOWNERS` may assign reviewers automatically.
  - Use Draft PRs for work in progress.
- **Labels**: apply relevant labels (e.g., `enhancement`, `breaking change`, `needs review`).

---

## 3) Branching / Naming
- Recommended naming:
  - `feature/<ticket>-description` or `feat/<ticket>-description`
  - `fix/<ticket>-description`
  - `docs/<description>`
  - `chore/<description>`
- Keep branches short (one logical unit per branch).

---

## 4) Merge strategy
- **Recommended (default)**: **Squash and merge** for feature and docs PRs — produces a clean single commit on `main` and simplifies changelogs.
- **Alternative**: **Rebase and merge** to preserve atomic commits.
- **Merge commit**: use only for releases or complex integrations when explicit history is useful.
- **After merge**: delete remote branch (available via merge UI), move Project card to Done, and close related issue if applicable.

**Suggested squash commit message:** `type(scope): subject — Closes #12`.

---

## 5) What a good merge/PR message contains
- Short summary (type/scope/operation)
- If applicable, `Closes #n` to automatically close the issue
- Migration notes when there are BREAKING CHANGES

---

## 6) Example — Issue
**Title:** `bug: error validating token in production`
**Body:**
- Environment: Python 3.11, Ubuntu 22.04
- Steps: ...
- Expected: ...
- Actual: ...

---

## 7) Example — PR
**Title:** `fix(auth): handle refresh for expired token`
**Body:**
- Description: Fixes exception when trying to refresh an already expired token.
- Tests: Unit tests added for `refresh_token`.
- How to test:
  - `pytest tests/test_auth.py::test_refresh_expired`
- Checklist:
  - [x] Tests
  - [x] Lint
  - [x] Docs (README updated)

---

## 8) Recommended automations
- **Labeler**: apply labels based on path (`docs/**` -> `docs`, `*.py` -> `enhancement/test`).
- **Stale bot**: close issues with no activity after X days.
- **CI checks**: require CI success before merge.
- **Project automations**: move cards on PR open/merge.

---

## 9) Useful commands
- Create PR with CLI: `git push -u origin <branch>` and `gh pr create --base main --head <branch> --draft`
- Amend last commit message: `git commit --amend -m "type: subject"`
- Interactive rebase: `git rebase -i origin/main` + `git push --force-with-lease`

---

## 10) Ideal summary
- Templates for Issues and PRs (present in `.github/`)
- Mandatory PR checklist (tests, linter, docs)
- Squash-and-merge by default
- CI checks + required review (or CODEOWNERS)
- Language note: English is the default (types in English, subjects/body/footers in English)

---