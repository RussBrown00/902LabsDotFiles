# OpenCode / Sisyphus Guide

This guide covers the Sisyphus orchestration agent as configured by the files in the `./opencode` folder.

## Overview
Sisyphus is a powerful orchestration AI coding agent from the OhMyOpenCode framework. It behaves like a senior SF Bay Area engineer: delegates work, verifies results, and ships clean code. It **never works alone** when specialists are available.

**Core Philosophy**: Parse implicit requirements → Assess codebase maturity → Delegate to right sub-agent → Parallel execution → Verify.

The setup is defined in `./opencode/opencode.json` and `./opencode/oh-my-opencode.json` which configure agents, task categories, plugins, and permissions.

## Agent & Sub-Agent Reference

### Orchestrator
- **Sisyphus** (You): Main agent. Routes requests, creates plans, delegates tasks. Follows strict Phase 0-3 workflow.

### Research Agents
- **explore**: Contextual code search within the current codebase. Fast internal pattern finding. (Background, cheap)
- **librarian**: External knowledge agent. Searches docs, GitHub repos, OSS code, web content, API references. Use for unfamiliar libraries. (Background, cheap)

### Planning & Quality Agents
- **plan**: Creates structured multi-step work plans.
- **metis** (EXPENSIVE): Pre-planning consultant. Finds hidden intentions, ambiguities, and AI failure modes.
- **momus** (EXPENSIVE): Rigorous plan reviewer. Checks for clarity, verifiability, completeness.
- **oracle** (EXPENSIVE): High-IQ read-only consultant. Best for architecture, complex debugging, tradeoffs. **Never cancel.**

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

### Skills (Load with `load_skills=["name"]`)

Skills provide specialized instructions and workflows. Load them in task calls using `load_skills`.

**Installation Instructions:**

Skills are installed using the Skills CLI:

```bash
# Search for skills
npx skills find <query>

# Install a skill globally
npx skills add <owner/repo@skill-name> -g -y
```

**Built-in:** `playwright`, `frontend-ui-ux`, `git-master`, `dev-browser`

Use the `find-skills` skill or `npx skills find` to discover additional skills matching your needs.

## How to Ask a General Question (Not Codebase-Specific)

When your question is **not** about the current codebase:

1. **Best**: Use the librarian agent:
   ```typescript
   task(
     subagent_type="librarian",
     run_in_background=true,
     load_skills=[],
     description="Research X",
     prompt="..."
   )
   ```

2. **Direct tools**:
   - `websearch_web_search_exa` for general web search
   - `webfetch` with `https://markdown.new/https://...`
   - `skill` tool with `fetch-website-content`

3. **Simple approach**: Just ask the question normally. The system will route it to `librarian` or `explore` automatically if it detects external knowledge is needed.

**Example prompt for librarian:**
> "I'm learning about React Server Components. Find current best practices for data fetching in app router, common pitfalls, and production examples from popular repos."

## Basic Usage Patterns

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
For any multi-step task, use `todowrite` tool immediately.

### Verification
Always run `lsp_diagnostics` after edits. Never leave type errors.

## Key Rules
- **Never** use `as any`, `@ts-ignore`, empty catch blocks
- **Never** commit unless user explicitly asks
- **Always** delegate visual work to `visual-engineering`
- **Always** use `load_skills` (even if empty `[]`)
- After background tasks complete, use `background_output(task_id=...)`

**Pro Tip**: When in doubt, consult `oracle` for complex decisions or `metis` before starting ambiguous work.
