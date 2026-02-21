---
name: wtadd-release
description: Run the wtadd release workflow end-to-end. Use when preparing a new wtadd version, updating CHANGELOG.md, tagging, pushing, and creating a GitHub release.
disable-model-invocation: true
argument-hint: [version]
allowed-tools: Read, Bash(git *), Bash(gh *), Bash(sed *), Bash(cat *)
---

# wtadd Release

## Quick Start

Use this skill when cutting a new release for `abuiles/wtadd`.

Example:
- `/wtadd-release v0.1.2`

If no version is provided, infer the next patch version from the latest tag.

## Workflow

### 1. Preconditions

- Be in repo root.
- Ensure clean working tree:
  - `git status -sb`
- Ensure branch is up to date:
  - `git pull --ff-only origin main`

If either check fails, stop and report what needs to be fixed.

### 2. Determine Version and Date

- Version comes from `$ARGUMENTS` if provided (must match `vX.Y.Z`).
- If missing:
  - inspect latest semver tag with `git tag --sort=-version:refname`
  - bump patch by default
- Release date:
  - `date +%Y-%m-%d`

### 3. Update `CHANGELOG.md`

- Keep Keep a Changelog style:
  - `## [X.Y.Z] - YYYY-MM-DD`
  - `### Added`, `### Changed`, `### Fixed` as needed
- Summarize user-facing changes since previous tag:
  - `git log --oneline <previous_tag>..HEAD`
- Update bottom links:
  - `[X.Y.Z]: https://github.com/abuiles/wtadd/compare/<previous_tag>...<new_tag>`

Also ensure previous release link exists:
- `[0.1.0]: https://github.com/abuiles/wtadd/releases/tag/v0.1.0`

### 4. Update README Pinned Install Example

- Find pinned install example:
  - `VERSION=v...`
- Set it to new version.

### 5. Validate Before Commit

- Sanity checks:
  - `bash -n wt install.sh`
  - `./wt help`
- Review diff:
  - `git diff -- CHANGELOG.md README.md`

### 6. Commit and Push

- Commit only release-prep files:
  - `git add CHANGELOG.md README.md`
  - `git commit -m "Prepare <new_tag> release"`
- Push:
  - `git push origin main`

### 7. Tag and Release

- Create tag (annotated preferred):
  - `git tag -a <new_tag> -m "<new_tag>"`
  - fallback: `git tag <new_tag>`
- Push tag:
  - `git push origin <new_tag>`
- Create GitHub release with notes from changelog section for new version:
  - `gh release create <new_tag> --repo abuiles/wtadd --title "<new_tag>" --notes-file <temp_notes_file>`

When generating notes file, avoid inline shell text that can be interpreted by shell.

### 8. Post-Release Verification

- Confirm release URL returned by `gh`.
- Confirm local is synced:
  - `git status -sb`
- Confirm tag exists:
  - `git tag --sort=-creatordate | head`

## Output Template

Report:
- Version released
- Commit SHA used for tag
- Release URL
- Files changed for release prep
- Any fallbacks used (for example lightweight tag instead of annotated)

