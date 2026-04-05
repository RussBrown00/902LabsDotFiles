# Oh My OpenAgent / Sisyphus Guide

This guide covers the Sisyphus orchestration agent as configured by the files in the `./opencode` folder.

## Overview

Sisyphus is a powerful orchestration AI coding agent from the Oh My OpenAgent framework. It behaves like a senior SF Bay Area engineer: delegates work, verifies results, and ships clean code. It **never works alone** when specialists are available.

**Core Philosophy**: Parse implicit requirements → Assess codebase maturity → Delegate to right sub-agent → Parallel execution → Verify.

See full details in [DeepWiki Overview](https://deepwiki.com/code-yeongyu/oh-my-openagent/1-overview).

The active setup is defined by `./opencode/oh-my-openagent.json` for agent/category configuration, `./opencode/AGENTS.md` for local operating rules, and `./opencode/package.json` for OpenCode plugin dependencies.

## Agent & Sub-Agent Reference

### Orchestrator
- **Sisyphus** (You): Main agent. Routes requests, creates plans, delegates tasks. Follows strict Phase 0-3 workflow.

See [Sisyphus (Main Orchestrator)](https://deepwiki.com/code-yeongyu/oh-my-openagent/3.1-sisyphus-(main-orchestrator)).

### Research Agents
- **explore**: Contextual code search within the current codebase. Fast internal pattern finding. (Background, cheap)
- **librarian**: External knowledge agent. Searches docs, GitHub repos, OSS code, web content, API references. Use for unfamiliar libraries. (Background, cheap)

See full agent reference in [DeepWiki Agents](https://deepwiki.com/code-yeongyu/oh-my-openagent/3-agents).

### Execution, Planning & Quality Agents
- **git-operator**: Git-only specialist for status, commits, rebases, and other repository operations. Uses git commands only and follows stricter Git safety checks.
- **hephaestus**: Autonomous deep-work engineer for end-to-end implementation, verification, and bug fixing.
- **metis** (EXPENSIVE): Pre-planning consultant. Finds hidden intentions, ambiguities, and AI failure modes.
- **momus** (EXPENSIVE): Rigorous plan reviewer. Checks for clarity, verifiability, completeness.
- **oracle** (EXPENSIVE): High-IQ read-only consultant. Best for architecture, complex debugging, tradeoffs. **Never cancel.**
- **prometheus**: Planning-focused agent used for structured work plans and task decomposition.

### Task Categories (used with `task(category=...)`)
These determine which specialized model is used:

| Category              | Use Case                              | When to Use |
|-----------------------|---------------------------------------|-------------|
| `visual-engineering`  | UI, CSS, React components, design     | **Always** for frontend/visual work |
| `ultrabrain`          | Hard logic, algorithms, complex math  | Genuinely difficult problems only |
| `deep`                | Autonomous research + implementation  | Hairy, multi-step problems |
| `artistry`            | Creative, unconventional solutions    | When standard patterns aren't enough |
| `quick`               | Trivial changes, typos, single files  | Very small tasks |
| `writing`             | Docs, comments, READMEs               | Documentation tasks |
| `unspecified-high`    | Complex tasks that don't fit elsewhere| Default for most coding |
| `unspecified-low`     | Simple tasks that don't fit elsewhere | Default for minor work |

See [Categories System](https://deepwiki.com/code-yeongyu/oh-my-openagent/4.2-categories-system).

### Skills (Load with `load_skills=["name"]`)

Skills provide specialized instructions and workflows. Load them in task calls using `load_skills`.

This repo also ships project skills in `./opencode/skills` via git submodule. The older top-level `agent-skills/` folder was removed, so local skill references should point at `./opencode/skills/...` instead.

See [Skills System](https://deepwiki.com/code-yeongyu/oh-my-openagent/4.3-skills-system).

**Built-in:** `playwright`, `frontend-ui-ux`, `git-master`, `dev-browser`

**Repo-provided skills:** `create-skill`, `fetch-website-content`, `git-commit-instructions`, `git-squash-merge`, `javascript-development-guidance`, `javascript-jest`, `javascript/react-17-to-18`, `react-router-v7`, `webpack-expert`

Use `npx skills find` to discover additional skills matching your needs.

## How to Ask a General Question (Not Codebase-Specific)

When your question is **not** about the current codebase, use the librarian agent or direct tools.

See recommended patterns in [Usage Workflows](https://deepwiki.com/code-yeongyu/oh-my-openagent/9-usage-workflows).

## Basic Usage Patterns

See full usage patterns and examples in [Usage Workflows](https://deepwiki.com/code-yeongyu/oh-my-openagent/9-usage-workflows).

### Delegation (Most Common)
```typescript
task(
  category="deep",
  load_skills=[],
  description="Implement auth flow",
  prompt="Full detailed instructions here...",
  run_in_background=false
)
```

### Parallel Research
Fire multiple `explore` + `librarian` in background, then continue with independent work.

### Todo Tracking
For any multi-step task, use the task system immediately.

### Verification
Always run `lsp_diagnostics` after edits. Never leave type errors.

## Key Rules
- **Never** use `as any`, `@ts-ignore`, empty catch blocks
- **Never** commit unless user explicitly asks
- **Always** delegate visual work to `visual-engineering`
- **Always** use `load_skills` (even if empty `[]`)
- After background tasks complete, use `background_output(task_id=...)`

**Pro Tip**: When in doubt, consult `oracle` for complex decisions or `metis` before starting ambiguous work.

For complete documentation, visit the [Oh My OpenAgent DeepWiki](https://deepwiki.com/code-yeongyu/oh-my-openagent/).
