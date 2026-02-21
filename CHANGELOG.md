# Changelog

All notable changes to this project will be documented in this file.

## [0.1.1] - 2026-02-21

### Added
- `CHANGELOG.md` to track release history going forward.
- Documentation for reusing an existing branch with `wt add`.

### Changed
- `wt add` now resolves the default start-point dynamically in this order: `origin/HEAD`, current branch upstream, local `main`, local `master`.
- README updated with project naming and rationale improvements.

## [0.1.0] - 2026-02-20

### Added
- Initial `wt` CLI with `add`, `rm`, and `ls` commands.
- Interactive `wt rm` flow with support for `fzf` plus a numbered fallback menu.
- `.worktree-hook` onboarding for `wt add`, including non-blocking guidance when missing.
- `.env` copy behavior during worktree creation.
- Emacs shell-friendly interactive removal flow.
- Installer script with `curl | sh` support and pinned version installs via `VERSION=...`.

[0.1.1]: https://github.com/abuiles/wtadd/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/abuiles/wtadd/releases/tag/v0.1.0
