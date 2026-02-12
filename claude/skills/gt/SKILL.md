---
name: gt
description: Manage Graphite stacked PRs workflow — create branches, submit PRs, navigate stacks, sync, and resolve conflicts. Use this whenever the user wants to commit work, open PRs, manage stacked changes, or interact with Graphite. ALWAYS prefer Graphite over raw git for branching, committing, and PR operations.
argument-hint: "[action] [details]"
---

# Graphite Stacked PRs Skill

**IMPORTANT**: Always use Graphite (`gt`) instead of raw `git` for branching, committing, and PR operations. Graphite is the primary workflow tool. Specifically:
- Use `gt create` instead of `git checkout -b` + `git commit`
- Use `gt modify` instead of `git commit --amend`
- Use `gt submit` instead of `git push` + `gh pr create`
- Use `gt sync` instead of `git pull`/`git fetch` + `git rebase`
- Use `gt checkout`/`gt up`/`gt down` instead of `git checkout`/`git switch`
- **`gt` passes through unrecognized commands to `git`**, so ALWAYS use `gt` instead of `git` — even for operations like `reset`, `stash`, `diff`, `status`, `fetch`, `log`. Never invoke raw `git` directly.

You are managing a Graphite (`gt`) stacked PR workflow. Graphite enables stacking PRs on top of each other to keep changes small, focused, and reviewable.

## Interpreting the request

The user said: `$ARGUMENTS`

Map their intent to the appropriate workflow below. If `$ARGUMENTS` is empty or unclear, run `gt log short` to show the current stack state and ask what they'd like to do.

## Key Concepts

- **Stack**: A sequence of PRs, each building on its parent. e.g. `main <- PR1 <- PR2 <- PR3`
- **Trunk**: The base branch stacks merge into (usually `main`)
- **Downstack**: PRs below the current branch (ancestors)
- **Upstack**: PRs above the current branch (descendants)

## Workflows

### Create a new stacked branch

When the user wants to commit their current changes and create a new branch:

1. Run `gt status` and `gt diff --stat` to understand what changed
2. Stage the relevant files (prefer specific files over `gt add -A`)
3. Create the branch with a descriptive name and commit message:
   ```
   gt create <branch-name> -m "<commit message>"
   ```
   - Branch names: use kebab-case, be descriptive but concise (e.g. `add-kafka-consumer-config`)
   - Commit messages: imperative mood, explain the "why" not the "what"
   - If all changes should be staged: add `-a` flag
4. Show the result with `gt log short`

### Submit PRs (open/update PRs on GitHub)

When the user wants to push and open PRs:

- **Submit current branch + downstack** (default): `gt submit --no-edit`
- **Submit entire stack**: `gt submit --stack --no-edit`
- **Submit as draft**: `gt submit --draft --no-edit`
- **Submit and open in browser**: `gt submit --no-edit -v`

For new PRs that need titles/descriptions, generate good PR metadata:
1. Analyze the diff with `gt diff <parent-branch>...HEAD`
2. Run `gt submit` with `--no-edit` and let Graphite use the commit message, OR use `--edit-title --edit-description` only if the user explicitly wants to customize

Always use `--no-edit` by default to avoid interactive prompts. If the user wants AI-generated PR descriptions, use `--ai --no-edit`.

### Modify the current branch

When the user has new changes for the current branch:

1. Stage relevant changes
2. Amend into the current branch:
   ```
   gt modify -a -m "<updated message>"
   ```
   Or to keep the existing message:
   ```
   gt modify -a
   ```
   This automatically restacks descendants.

### Navigate the stack

- **View stack**: `gt log short` (compact) or `gt log` (detailed)
- **Move up**: `gt up` or `gt up <N>`
- **Move down**: `gt down` or `gt down <N>`
- **Go to top**: `gt top`
- **Go to bottom**: `gt bottom`
- **Switch branch**: `gt checkout <branch>`
- **Go to trunk**: `gt checkout main`

### Sync with remote

When the user wants to pull latest changes:

```
gt sync --force
```

This pulls trunk, rebases all open stacks, and cleans up merged branches. Use `--force` to skip confirmation prompts.

### Restack

When branches are out of date with their parent:

```
gt restack
```

If conflicts occur, inform the user and help resolve them. After resolving:
```
gt continue
```

To abort a conflicted operation:
```
gt abort
```

### View branch info

- **Current branch info**: `gt info`
- **Parent branch**: `gt parent`
- **Children branches**: `gt children`

### Insert a branch mid-stack

When the user wants to add a branch between existing stack entries:

```
gt create <name> -m "<message>" --insert
```

## Important Rules

1. **Never use interactive flags** — always pass `--no-interactive` or `--no-edit` where applicable, since Claude cannot interact with interactive prompts
2. **Always show `gt log short` after mutations** so the user sees the current state
3. **Never force push to trunk/main** — Graphite handles push strategy automatically
4. **Stage files explicitly** when possible rather than using `-a`, unless the user clearly wants all changes
5. **Run `gt restack` before `gt submit`** if you suspect the stack might be out of date
6. If a command fails due to conflicts, explain the situation clearly and help the user resolve it — do not use `--force` on restack/sync without asking
