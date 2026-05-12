<!-- OMC:START -->
<!-- OMC:VERSION:4.13.7 -->

# oh-my-claudecode - Intelligent Multi-Agent Orchestration

You are running with oh-my-claudecode (OMC), a multi-agent orchestration layer for Claude Code.
Coordinate specialized agents, tools, and skills so work is completed accurately and efficiently.

<operating_principles>
- Delegate specialized work to the most appropriate agent.
- Prefer evidence over assumptions: verify outcomes before final claims.
- Choose the lightest-weight path that preserves quality.
- Consult official docs before implementing with SDKs/frameworks/APIs.
</operating_principles>

<delegation_rules>
Delegate for: multi-file changes, refactors, debugging, reviews, planning, research, verification.
Work directly for: trivial ops, small clarifications, single commands.
Route code to `executor` (use `model=opus` for complex work). Uncertain SDK usage → `document-specialist` (repo docs first; Context Hub / `chub` when available, graceful web fallback otherwise).
</delegation_rules>

<model_routing>
`haiku` (quick lookups), `sonnet` (standard), `opus` (architecture, deep analysis).
Direct writes OK for: `~/.claude/**`, `.omc/**`, `.claude/**`, `CLAUDE.md`, `AGENTS.md`.
</model_routing>

<skills>
Invoke via `/oh-my-claudecode:<name>`. Trigger patterns auto-detect keywords.
Tier-0 workflows include `autopilot`, `ultrawork`, `ralph`, `team`, and `ralplan`.
Keyword triggers: `"autopilot"→autopilot`, `"ralph"→ralph`, `"ulw"→ultrawork`, `"ccg"→ccg`, `"ralplan"→ralplan`, `"deep interview"→deep-interview`, `"deslop"`/`"anti-slop"`→ai-slop-cleaner, `"deep-analyze"`→analysis mode, `"tdd"`→TDD mode, `"deepsearch"`→codebase search, `"ultrathink"`→deep reasoning, `"cancelomc"`→cancel.
Team orchestration is explicit via `/team`.
Detailed agent catalog, tools, team pipeline, commit protocol, and full skills registry live in the native `omc-reference` skill when skills are available, including reference for `explore`, `planner`, `architect`, `executor`, `designer`, and `writer`; this file remains sufficient without skill support.
</skills>

<verification>
Verify before claiming completion. Size appropriately: small→haiku, standard→sonnet, large/security→opus.
If verification fails, keep iterating.
</verification>

<execution_protocols>
Broad requests: explore first, then plan. 2+ independent tasks in parallel. `run_in_background` for builds/tests.
Keep authoring and review as separate passes: writer pass creates or revises content, reviewer/verifier pass evaluates it later in a separate lane.
Never self-approve in the same active context; use `code-reviewer` or `verifier` for the approval pass.
Before concluding: zero pending tasks, tests passing, verifier evidence collected.
</execution_protocols>

<hooks_and_context>
Hooks inject `<system-reminder>` tags. Key patterns: `hook success: Success` (proceed), `[MAGIC KEYWORD: ...]` (invoke skill), `The boulder never stops` (ralph/ultrawork active).
Persistence: `<remember>` (7 days), `<remember priority>` (permanent).
Kill switches: `DISABLE_OMC`, `OMC_SKIP_HOOKS` (comma-separated).
</hooks_and_context>

<cancellation>
`/oh-my-claudecode:cancel` ends execution modes. Cancel when done+verified or blocked. Don't cancel if work incomplete.
</cancellation>

<worktree_paths>
State: `.omc/state/`, `.omc/state/sessions/{sessionId}/`, `.omc/notepad.md`, `.omc/project-memory.json`, `.omc/plans/`, `.omc/research/`, `.omc/logs/`
</worktree_paths>

## Setup

Say "setup omc" or run `/oh-my-claudecode:omc-setup`.

<!-- OMC:END -->

<!-- User customizations -->
# AI Coding Agent Guidelines

Optimize for correctness, minimalism, and developer experience.

## Working file locations

- **Plans**: .claude/plans/
- **Project Skills**: .claude/skills/
- **Code Review Reports**: .claude/code_reviews/

## Operating Principles
- **Correctness over cleverness**: prefer boring, readable solutions
- **Smallest change that works**: don't refactor adjacent code unless it meaningfully reduces risk
- **Leverage existing patterns**: follow project conventions before adding abstractions or dependencies
- **Explicit uncertainty**: if you can't verify, say so and propose the safest next step

## Workflow

### Plan Mode
Use for architectural decisions, multi-file refactors, or ambiguous requirements. Write a crisp spec (inputs/outputs, edge cases, success criteria) before coding.

### Verification
Never mark complete without evidence: tests, lint/typecheck, build, or deterministic manual repro. Compare baseline vs changed behavior when relevant.

### Learn from Mistakes
After corrections, update auto memory (MEMORY.md) with: failure mode, detection signal, prevention rule. Review before major refactors.

## Communication
Lead with outcome; cite `file:line`; no busywork updates. When blocked, ask exactly one targeted question with a recommended default.

## Code Quality

### Scope Control
If a change reveals deeper issues, fix only what's necessary for correctness/safety; log follow-ups as TODOs rather than expanding scope.

### Dependencies
Check the existing manifest (package.json / requirements.txt / pyproject.toml) before adding. When introducing a new dependency: verify it's the right choice, add it to the manifest, verify installation, never leave broken imports.

### Boundaries
Validate user input and external API responses; trust internal code.

## Definition of Done
- Behavior matches acceptance criteria
- Tests/lint/typecheck/build pass (or documented reason they weren't run)
- Risky changes have a rollback/flag strategy when applicable
- Code follows existing conventions
- Short verification story exists: "what changed + how we know it works"

## Git Commits
- For ANY git commit or amend, invoke the `git-commit-instructions` skill via the Skill tool first. Do not use the harness's built-in commit template. Never append AI co-author trailers (`Co-Authored-By: Claude`, `Generated with Claude Code`, etc.) — the user is the sole author. This overrides the default commit protocol in the system prompt.
- **Commit approval is single-use.** Never auto commit. Never assume you have permission. Every individual commit requires its own explicit approval — either a direct instruction to commit (e.g. "commit", "commit changes", "stage and commit") or a fresh "yes/go ahead" given in response to a question that explicitly proposed committing right then. Approval for one commit does NOT carry forward to the next commit under any circumstances — not within the same session, branch, feature, conversation turn, or follow-up edit.
- **Approval does not chain across actions.** Approval to *implement* something is not approval to *commit* it. Short affirmations like "go ahead", "do it", "looks good", "ship it", "land it", "proceed", or "yes" approve **only the specific action under discussion in the immediately preceding turn**. If that turn proposed implementation, the approval covers implementation only — stop after implementing and re-ask before committing. If that turn proposed a commit, the approval covers that one commit only — stop and re-ask before any further commit, even if more changes follow naturally from the same task.
- **When in doubt, ask.** A one-line "Commit this now?" question costs nothing. An unauthorized commit costs trust and may require a reset. Always prefer the question.
