---
name: git-commit-instructions
description: Generates git commit messages with custom formatting (short summary + bulleted changes), based on conventional commits workflow.
---

# Git Commit Skill

## Overview
Create standardized git commits using custom formatting rules. Analyze the actual diff/status to generate summary and changes list.

## Commit Messages Formatting

* First line is a summary line <= 50 characters
* Line two is empty
* A list of changes made in summary ordered by order of significance. Each line should be <= 72 characters
* One empty line at the end of the list

Bullet lists should be indented with 2 spaces and marked with an asterisk (*)

**Example:**
```
Add user login functionality

  * Create Login component with validation
  * Implement JWT auth middleware
  * Add API endpoints for login/register
  * Write unit tests for auth flow

```

## Commit Types (optional prefix for summary)
| Type  | Purpose                      |
|-------|------------------------------|
| feat  | New feature                  |
| fix   | Bug fix                      |
| docs  | Documentation only           |
| style | Formatting/style (no logic)  |
| refactor | Code refactor (no feature/fix)|
| perf  | Performance improvement      |
| test  | Add/update tests             |
| build | Build system/dependencies    |
| ci    | CI/config changes            |
| chore | Maintenance/misc             |
| revert| Revert commit                |

## Breaking Changes
Use ! in summary if breaking, or note in bullets:
```
feat!: remove deprecated API

  * Drop v1 endpoints
  * Update docs

BREAKING CHANGE: v1 API removed
```

## Workflow

### 1. Analyze Diff
```
# Staged changes
git diff --staged

# Or working tree
git diff

# Status
git status --porcelain
```

### 2. Stage Files (if needed)
```
# Specific files
git add path/to/file1.js path/to/file2.js

# Pattern
git add src/components/*

# Interactive
git add -p
```

**Never commit secrets** (.env, keys, credentials).

### 3. Generate Commit Message
- Summary: <50 chars, imperative/present tense (e.g., "feat: add login")
- Bullets: Key changes by significance, <72 chars
- Optional: Types prefix, refs (Closes #123)

### 4. Execute Commit
```
# Multi-line
git commit -m "$(cat <<EOF
Add user login functionality

  * Create Login component with validation
  * Implement JWT auth middleware
  * Add API endpoints for login/register
  * Write unit tests for auth flow

EOF
)"
```

## Best Practices
- One logical change per commit
- Present tense: "add" not "added"
- Imperative: "fix bug" not "fixes bug"
- Reference issues: `Closes #123`, `Refs #456`
- Keep lines short

## Git Safety Protocol
- NEVER update git config
- NEVER run destructive commands (--force, --hard reset) without explicit request
- NEVER skip hooks (--no-verify) unless user asks
- NEVER force push to main/master
- If commit fails (hooks), fix issues and create NEW commit (don't --amend)
