# User Preferences — Ryan van Huuksloot

## Core Principles
- **Continuously improve your own setup.** When you learn something new about the user's workflow, hit a mistake you could prevent next time, or discover a better pattern — update your memory files (`~/.claude/projects/*/memory/`), skills (`~/.claude/skills/`), or this CLAUDE.md. Don't wait to be asked. Every session should leave the setup a little better than it started.

## Working Style
- Work autonomously. Do as much as possible without asking. Only confirm for irreversible/destructive actions.
- Keep responses concise and action-oriented.

## Git & PR Workflow
- **Always use Graphite (`gt`) over raw `git`** for branching, committing, and PR operations.
  - `gt create` not `git checkout -b` + `git commit`
  - `gt modify` not `git commit --amend`
  - `gt submit` not `git push` + `gh pr create`
  - `gt sync` not `git pull`/`git rebase`
  - Only use raw `git` for things Graphite doesn't cover (`git stash`, `git diff`, `git status`, etc.)
- Use the `/gt` skill for any Graphite workflow.

## Worktrees
- **Use `dev tree` for all new features/branches** — treat worktrees as the default way to start new work, not regular branches.
  - New feature? → `dev tree add <feature-name> --switch` first, then work inside the worktree.
  - Always use `dev tree` instead of `git worktree`.
  - When suggesting a new branch for work, suggest creating a worktree instead.

## Zellij Agent Dashboard
- When running inside Zellij (check: `$ZELLIJ` env var is set):
  - **Keep your tab name updated** to reflect what you're currently working on.
    - At the start of a session, rename the tab: `zellij action rename-tab "short-task-name"`
    - When the focus of your work shifts significantly, update the tab name.
    - Keep tab names short (max ~25 chars), lowercase kebab-case.
  - **Write your status** to the agents dashboard so the sidebar stays current:
    - `echo -e "running\nshort description of current work" > /tmp/agents-status/$(zellij action query-tab-names 2>/dev/null | head -1)`
    - Update status when starting work (`running`), waiting for input (`waiting`), finished (`done`), or on error (`error`).
    - Update the description line to reflect what you're currently doing.
    - Do this at the start of a task and whenever your focus shifts.

## Languages & Tools
- Primary: Java, Go, YAML/Kubernetes, Terraform
- Works across: Flink/streaming, infrastructure/platform, Kubernetes
- Shopify developer: uses `dev` CLI tool, Shopify conventions
