## Communication Guidelines

### Be Concise, High-Signal
- Lead with outcome and impact, not process
- Reference concrete artifacts: file paths, command names, error messages, what changed
- Avoid dumping large logs; summarize and point to where evidence lives

## Operating Principles

- **Correctness over cleverness**: Prefer boring, readable solutions that are easy to maintain
- **Smallest change that works**: Minimize blast radius; don't refactor adjacent code unless it meaningfully reduces risk or complexity
- **Leverage existing patterns**: Follow established project conventions before introducing new abstractions or dependencies
- **Prove it works**: "Seems right" is not done. Validate with tests/build/lint and/or a reliable manual repro
- **Be explicit about uncertainty**: If you cannot verify something, say so and propose the safest next step to Verify

## File Organization

- **Store all generated workflow files in `.agents/` at project root**: plans, notes, documentation, specs, analysis artifacts
- Organize using subdirectories: `.agents/docs/`, `.agents/plans/`, `.agents/notes/`, etc.
- Never create generated files in the main project directory unless explicitly requested

## Website Lookups

Any browser lookups should be run through markdown.new to convert the webpages to markdown for consumtion. Simply prepend
`https://markdown.new/` before any url: e.g. `https://markdown.new/https://www.photivo.com`

## Code Quality

### Control Scope Creep
- If a change reveals deeper issues: fix only what is necessary for correctness/safety
- Log follow-ups as TODOs/issues rather than expanding the current task

### Project-Specific Preferences
- Don't add dependencies unless existing stack cannot solve it cleanly
- Validate at boundaries (user input, external APIs); trust internal code

### Dependency Management
- Before using a new library, check if it's already in package.json/requirements.txt/pyproject.toml
- If adding a new dependency:
  - Verify it's the right choice (prefer existing stack)
  - Add it to the appropriate manifest file (package.json/requirements.txt/etc.)
  - Verify installation or prompt to install (pip list, npm list, etc.)
  - Don't leave broken imports that will fail at runtime

### Commit Discipline
- Ask before creating workflow WIP (work in progress) commits
- Keep commits atomic and describable; avoid "misc fixes" bundles
- Don't rewrite history unless explicitly requested
- Don't mix formatting-only changes with behavioral changes unless the repo standard requires it
- Assume any commit request expects you to add all uncommited files to the commit unless direct otherwise
- Do not disobey the gitignore config, under any circumstances, even if asked!

### Autonomous Bug Fixing
- When given a bug report: reproduce → isolate root cause → fix → add regression coverage → verify
- Don't offload debugging work to the user unless truly blocked
- If blocked, ask for **one** missing detail with a recommended default
