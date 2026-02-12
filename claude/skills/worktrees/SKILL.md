---
name: worktrees
description: Manage git worktrees using `dev tree`. Use this when the user wants to create, list, switch, or remove worktrees for parallel workstreams.
argument-hint: "[action] [worktree name]"
---

# Git Worktrees Skill

**Always use `dev tree` instead of raw `git worktree`** for managing worktrees.

The user said: `$ARGUMENTS`

Map their intent to the appropriate workflow below. If `$ARGUMENTS` is empty, run `dev tree list` to show current worktrees and ask what they'd like to do.

## Commands

### List worktrees
```
dev tree list
```
The `*` indicates the current active worktree.

### Create a new worktree
```
dev tree add <worktree_name>
```
- Use a descriptive name (e.g. `fix-kafka-config`, `add-new-pipeline`)
- Add `--switch` / `-s` to immediately cd into the new worktree after creation

### Switch to a worktree
```
dev tree switch <worktree_id>
```
Switches to the same relative path within the target worktree.

### Show worktree info
```
dev tree show <worktree_id>
```
Use `dev tree show .` to show info about the current worktree.

### Remove a worktree
```
dev tree remove <worktree_id>
```
- Add `--force` / `-f` to remove even if the worktree has uncommitted changes
- Add `--yes` / `-y` to skip the confirmation prompt
- **Always confirm with the user before using `--force`** as this discards uncommitted work

## When to suggest worktrees

Worktrees are useful when the user wants to:
- Work on multiple branches simultaneously without stashing
- Keep a long-running task going while doing a quick fix on another branch
- Review/test a PR locally while their current work stays intact
- Run builds or tests on one branch while editing another
