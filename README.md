# wtadd

Minimal git worktree helper for local CLI workflows.

## Rationale

I was tired of repeating setup every time I created a new worktree: rerunning install steps and moving files around.

The `.worktree-hook` flow in `wtadd` simplifies that local workflow by automating setup right after worktree creation.

## Install

Using `curl | sh` (recommended):

```bash
curl -fsSL https://raw.githubusercontent.com/abuiles/wtadd/main/install.sh | sh
```

Install a pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/abuiles/wtadd/main/install.sh | VERSION=v0.1.0 sh
```

Local install from cloned repo:

```bash
sh install.sh
```

## Commands

```bash
wt add <name> [start-point]
wt rm [name]
wt ls
```

Defaults:
- `start-point` is resolved automatically in this order: `origin/HEAD`, current branch upstream, local `main`, local `master`
- worktree path is `wt-<name>`
- branch name defaults to `<name>`
- if branch `<name>` already exists locally, `wt add` reuses it instead of creating a new one

## Hook behavior for `wt add`

- If `.worktree-hook` exists in repo root, `wt` runs it inside the new worktree.
- If it does not exist:
  - interactive terminal: asks whether to create one now
  - non-interactive terminal: prints setup instructions and continues
- If you choose to create it, `wt` creates an executable shebang-only `.worktree-hook` and does not run it in that command.

Suggested hook content:

```bash
#!/usr/bin/env bash
set -euo pipefail

yarn
cp -r ../.wrangler .wrangler/
cp ../.dev.vars .
```

## Emacs shell compatibility

`wt` supports Emacs `M-x shell` / comint sessions.

- Prompts work in Emacs shell for interactive flows.
- `wt rm` uses the numbered selection menu in Emacs shell (instead of `fzf`) for reliability.
- The menu shows both a short name and full path so you can identify the right worktree quickly.
