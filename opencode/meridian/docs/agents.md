# Agent Roster — `oh-my-openagent.json`

Reference breakdown of every agent declared in `oh-my-openagent.json`. For each agent: **purpose** (what it does), **invocation** (when it's used), and **model strengths** (what the underlying model needs to be good at).

> Source of truth: `oh-my-openagent.json` (root of the meridian project). Update this doc whenever an agent's model, variant, or role changes.

---

## Quick Reference Matrix

| Agent | Model | Variant | Role |
|---|---|---|---|
| `sisyphus` | claude-sonnet-4-6 | high (xhigh in ultrawork) | Top-level orchestrator |
| `hephaestus` | claude-opus-4-8 | high | Primary implementer |
| `prometheus` | claude-opus-4-8 | high | Planner |
| `oracle` | claude-opus-4-8 | max | Read-only consultant |
| `librarian` | claude-haiku-4-5 | low | External reference grep |
| `explore` | claude-haiku-4-5 | low | Internal codebase grep |
| `multimodal-looker` | gpt-5.5 | medium | Visual / multimodal analysis |
| `metis` | claude-opus-4-8 | xhigh | Pre-planning critic |
| `momus` | claude-opus-4-8 | high | Plan / code reviewer |
| `atlas` | claude-sonnet-4-6 | medium | General-purpose worker |
| `sisyphus-junior` | claude-sonnet-4-6 | medium | Category delegate runner |
| `git-operator` | claude-haiku-4-5 | low | Git-only operator |
| `argus` | gpt-5.5 | high | Cross-LLM validator |
| `clio` | claude-sonnet-4-6 | high | Read-only research agent |

---

## sisyphus
**Model:** `anthropic/claude-sonnet-4-6` · variant `high` (auto-upgrades to `xhigh` under ultrawork)

**What it does**
Top-level orchestrator. Receives the raw user request, classifies intent, decomposes work into atomic subtasks, and dispatches them in parallel to specialist agents and categories. Owns final synthesis and user-facing reply. Does very little "hands-on" work — its job is decision-making and coordination.

**When it's used**
Every session. It is the default entry point. Permission config grants it unrestricted `task: *` access so it can spawn any other agent.

**Model strengths required**
- Strong reasoning under ambiguity (intent inference from terse prompts).
- Reliable tool-use discipline (parallel `task()` calls, no duplicated work).
- Long-context tracking across many concurrent background agents.
- Calibrated restraint — knows when *not* to act (clarification, waiting on Oracle, etc.).

---

## hephaestus
**Model:** `anthropic/claude-opus-4-8` · variant `high`

**What it does**
Primary implementation agent. Edits code, runs git/test commands, uses LSP and AST-grep aggressively. Owns the codebase: explores, decides, executes. Permission grants `edit: allow` and `bash.git/test: allow`.

**When it's used**
When the orchestrator needs sustained file-touching work — multi-file edits, refactors, feature implementation, fix-then-verify loops — and the task isn't worth burning Opus on.

**Model strengths required**
- Solid code generation and refactoring across multiple languages.
- Disciplined tool use (LSP diagnostics, AST-grep patterns, deterministic edits).
- Fast iteration (Sonnet tier latency) without sacrificing correctness.
- Pattern-matching to existing codebase conventions.

---

## prometheus
**Model:** `anthropic/claude-opus-4-8` · variant `high`

**What it does**
Plan creator. Produces concise, structured work plans focused on file structure and key decisions. Output is meant to be handed to implementers (hephaestus, sisyphus-junior).

**When it's used**
Before non-trivial implementation when scope is unclear or spans multiple files/modules. Typically invoked after exploration and before any edits.

**Model strengths required**
- Architectural reasoning and decomposition.
- Brevity — plans must be skimmable, not exhaustive.
- Sense of what to leave out (no premature implementation detail).
- Clear sequencing and dependency awareness.

---

## oracle
**Model:** `anthropic/claude-opus-4-8` · variant `max`

**What it does**
Read-only high-IQ consultant. No edits, no writes, no commits. Answers hard architecture, debugging, and tradeoff questions with deep analysis. Self-review pass for significant implementations.

**When it's used**
- Complex architecture design decisions.
- After 2+ failed fix attempts on the same bug.
- Self-review of significant completed work.
- Unfamiliar code patterns or security/performance concerns.
- Multi-system tradeoff analysis.

NOT used for trivial decisions, first-attempt debugging, or anything inferable from the code directly.

**Model strengths required**
- Maximum reasoning depth — `variant: max` is intentional.
- Tolerance for long, dense context.
- Conservative, evidence-based recommendations (no speculation).
- Ability to identify root causes, not symptoms.

---

## librarian
**Model:** `anthropic/claude-haiku-4-5` · variant `low`

**What it does**
External reference grep. Searches docs sites, open-source repos, official API references, and the web for usage patterns and best practices for libraries/frameworks the orchestrator isn't already familiar with.

**When it's used**
Whenever the task involves an unfamiliar library, SDK, framework, or external API. Trigger phrases: "How do I use [library]?", "Best practice for [framework feature]?", "Find examples of [package] usage."

**Model strengths required**
- Fast retrieval and summarization (Haiku tier is sufficient).
- Reliable source quoting — doesn't hallucinate docs.
- Discrimination between authoritative and low-quality sources.
- Concise output — orchestrator just needs the answer, not a tutorial.

---

## explore
**Model:** `anthropic/claude-haiku-4-5` · variant `low`

**What it does**
Internal codebase grep. Contextual search across the local repository — finds implementations, patterns, similar code, conventions. Fired liberally in parallel for discovery.

**When it's used**
- Any non-trivial codebase question requiring 2+ search angles.
- Unfamiliar module structure.
- Cross-layer pattern discovery (e.g., "find all auth-related code").
- Always fired with `run_in_background=true`, often 2-5 instances in parallel.

NOT used when the file location is already known or a single grep suffices.

**Model strengths required**
- Fast, cheap retrieval (low-tier model is fine).
- Strong instruction following for tightly-scoped search prompts.
- Clean output formatting (file paths + pattern descriptions).
- Comfort with large code corpora.

---

## multimodal-looker
**Model:** `openai/gpt-5.5` · variant `medium`

**What it does**
Visual / multimodal analysis. Reads images, screenshots, design files, diagrams, PDFs — anything where the signal is in pixels rather than text.

**When it's used**
- UI screenshot inspection ("does this match the design?").
- Diagram interpretation.
- Multimodal artifacts the text-only agents can't parse.

**Model strengths required**
- Native multimodal capability (GPT-5.5 chosen specifically for vision).
- Accurate spatial / layout reasoning.
- Ability to ground textual claims in visual evidence.

---

## metis
**Model:** `anthropic/claude-opus-4-8` · variant `xhigh`

**What it does**
Pre-planning critic. Before a plan is even written, metis analyzes the user's request to surface hidden intentions, ambiguities, scope risks, and likely AI failure points. Output is critique, not solution.

**When it's used**
- Complex requests where scope is ambiguous.
- Before invoking Prometheus on high-stakes work.
- When the request has multiple plausible interpretations and the cost of guessing is high.

**Model strengths required**
- Adversarial reasoning — actively searching for what could go wrong.
- High recall on ambiguity / under-specification.
- Restraint — doesn't solve, only critiques.
- Pattern recognition for common LLM failure modes.

---

## momus
**Model:** `anthropic/claude-opus-4-8` · variant `high`

**What it does**
Reviewer specialized in code quality, edge cases, and test coverage. Also reviews work plans against strict clarity/verifiability/completeness standards.

**When it's used**
- Plan review before execution (paired with the `plan-review` skill).
- Code-quality pass on completed implementations.
- Catching missed edge cases or thin test coverage.

**Model strengths required**
- Skeptical reading — assume the work is wrong until proven otherwise.
- Strong edge-case enumeration.
- Familiarity with testing patterns and coverage gaps.
- Concrete, actionable critique (no vague "consider improving X").

---

## atlas
**Model:** `anthropic/claude-sonnet-4-6` · variant `medium`

**What it does**
General-purpose worker. No custom `prompt_append` — behaves as a flexible Sonnet-tier agent the orchestrator can hand miscellaneous structured tasks to without burning Opus or a specialist.

**When it's used**
- Mid-weight tasks that don't fit a specialist (not pure code, not pure planning, not pure review).
- When parallel throughput matters and Sonnet quality is sufficient.

**Model strengths required**
- Broad competence across writing, light coding, summarization, structured output.
- Reliable instruction following.
- Reasonable cost/latency profile (medium variant).

---

## sisyphus-junior
**Model:** `anthropic/claude-sonnet-4-6` · variant `medium`

**What it does**
Category delegate runner. When the orchestrator delegates via `task(category=...)`, this is the agent that actually runs the category-configured model. Acts as the orchestrator's hands for category-based work.

**When it's used**
Any time `task()` is called with a `category` argument (e.g., `quick`, `deep`, `visual-engineering`). Spun up automatically as part of the category delegation system.

**Model strengths required**
- Strong instruction adherence — runs whatever skills and constraints are loaded.
- Predictable behavior under varied category configs.
- Sonnet-tier reasoning as the baseline floor when a category swaps in a different model on top.

---

## git-operator
**Model:** `anthropic/claude-haiku-4-5` · variant `low`

**What it does**
Git-only operator. Strictly bash + read-only inspection (`status`, `log`, `diff`, `remote -v`). Edit/write tools are explicitly denied. Loads `git-commit-instructions` and `git-squash-merge` skills. Refuses destructive commands (`reset --hard`, `clean -fd`, `push --force`, history rewrites) unless explicitly requested.

**When it's used**
- Branch creation/switching.
- Fetch/pull (prefers `--ff-only`).
- Commit and amend with skill-driven message formatting.
- Rebase/cherry-pick and merge conflict assistance.
- Push/tag/release branch hygiene.

**Model strengths required**
- Strict tool-discipline (Haiku is enough — task is mechanical).
- Reliable command sequencing (pre-checks → action → post-checks).
- Skill-loading fidelity (must honor `git-commit-instructions` exactly).
- Low risk tolerance — never improvises on destructive operations.

---

## argus
**Model:** `openai/gpt-5.5` · variant `high`

**What it does**
Cross-LLM validator. Reviews code or plans produced by Anthropic-family agents and returns a structured feedback report (`Verdict` / `Critical Issues` / `Concerns` / `Observations` / `Blind Spots` / `Questions for Parent`). Read-only — edit, write, and task tools all denied.

**When it's used**
- Pre-commit / pre-merge validation of significant work.
- Plan validation before execution.
- Whenever same-family review (Claude reviewing Claude) would share blind spots — Argus brings genuine model diversity.

**Model strengths required**
- **Must be a non-Anthropic family model** — this is the entire point of Argus. GPT-5.5 chosen specifically for the cross-family perspective.
- Sharp critical reading and edge-case enumeration.
- Discipline to refuse implementation requests and stay in reviewer role.
- Calibrated severity — distinguishes blockers from nitpicks without softening either.

---

## clio
**Model:** `anthropic/claude-sonnet-4-6` · variant `high`

**What it does**
Read-only research agent. Investigates a question across the local codebase and returns a synthesized answer (Answer / Evidence / Caveats / Next Lookups). Never edits, writes, or commits.

**When it's used**
- Targeted factual lookups inside the codebase ("what version of X are we on?", "where is Y wired up?").
- Topic summarization across files ("what patterns does this repo use for Z?").
- Whenever a clear, citation-backed answer is wanted but the orchestrator does not need code touched.

NOT used for cross-LLM critique (that's `argus`), planning critique (that's `metis` / `momus`), or external library research (that's `librarian`).

**Model strengths required**
- Synthesis — collapses multiple search hits into one coherent answer.
- Disciplined citation (`file:line`) without invention.
- Restraint — refuses to drift into implementation suggestions.
- Cheap enough to fire freely, smart enough to be trusted with the final answer (Sonnet high is the floor).

---

## Notes on Categories vs. Agents

The same JSON also defines **categories** (`quick`, `deep`, `ultrabrain`, `visual-engineering`, `writing`, etc.) which are model/variant presets the orchestrator selects via `task(category=...)`. Categories are runtime configurations executed by `sisyphus-junior`; named agents above are distinct identities with their own prompts, permissions, and skills. When in doubt: use a named agent for *role*, a category for *domain-tuned compute*.
