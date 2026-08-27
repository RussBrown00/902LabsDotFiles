# OpenCode Configurations

This directory contains four selectable OpenCode configurations. Each profile has
its own provider, model, plugin, MCP, and agent settings while sharing the skill
library in `opencode/skills/`.

## Profiles

| Profile | Default model | Use it when |
| --- | --- | --- |
| [`gptgrok/`](gptgrok/README.md) | `openai/gpt-5.6-sol` | OpenAI should be primary, with xAI and OpenCode available for selected reasoning, review, and art roles. |
| [`gptsetup/`](gptsetup/README.md) | `openai/gpt-5.6-sol` | OpenAI should be the primary model family, with xAI available for selected review and reasoning roles. |
| [`meridian/`](meridian/README.md) | `anthropic/claude-sonnet-4-6` | Anthropic should be the primary model family through the local Meridian bridge (`./plugin/meridian.ts` + proxy on `:3456`). |
| [`shotgun/`](shotgun/README.md) | `openai/gpt-5.6-sol` | GPT 5.6 Sol should stay the default while Sisyphus normal and ultrawork orchestration use Claude Opus 4.8 through the Meridian Anthropic bridge. |

The top-level `opencode/` directory is a container for these profiles; it is not
itself the active OpenCode configuration. Link one profile to
`~/.config/opencode`.

## Shared and Profile-Specific Files

```text
opencode/
|-- skills/                 # Shared skill definitions
|-- gptgrok/
|   |-- agents/             # GPT, xAI, and OpenCode agent definitions
|   |-- skills -> ../skills # Shared skill symlink
|   `-- opencode.json
|-- gptsetup/
|   |-- agents/             # OpenAI-oriented agent definitions
|   |-- skills -> ../skills # Shared skill symlink
|   |-- opencode.json
|   `-- oh-my-openagent.json
|-- meridian/
|   |-- agents/             # Anthropic-oriented agent definitions
|   |-- skills -> ../skills # Shared skill symlink
|   |-- opencode.json
|   `-- oh-my-openagent.json
`-- shotgun/
    |-- agents/             # GPT Grok agents with Claude routing overrides
    |-- skills -> ../skills # Shared skill symlink
    |-- opencode.json
    `-- oh-my-openagent.json
```

Skills belong in the parent `skills/` directory. The relative symlink in each
profile makes the same skills available regardless of which profile is active.
Do not replace a profile's `skills` symlink with a copied directory.

Agent files are intentionally profile-specific. Although
`oh-my-openagent.json` assigns models to agents and task categories, that model
selection is not always applied reliably by the plugin alone. Definitions in
each profile's `agents/` directory keep direct agent behavior local and provide
a second place to declare a model when an explicit fallback is needed. When
changing an agent's model, review both `oh-my-openagent.json` and the matching
`agents/*.md` file.

## Installation

These dotfiles use manual symbolic links. Clone the repository to
`~/.dotfiles`, then choose one profile.

Back up an existing OpenCode configuration first:

```bash
mv ~/.config/opencode ~/.config/opencode.backup
```

If `~/.config/opencode` does not exist, skip that command.

### GPT Grok profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/gptgrok ~/.config/opencode
```

### GPT setup profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/gptsetup ~/.config/opencode
```

### Meridian profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/meridian ~/.config/opencode
```

### Shotgun profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/shotgun ~/.config/opencode
```

Creating a profile directory in this repository does not activate it. Only the
target of `~/.config/opencode` decides which profile OpenCode loads.

Install the selected profile's local Node dependency:

```bash
cd ~/.config/opencode
npm install
```

## Switching Profiles

The active configuration is determined by the target of
`~/.config/opencode`. To switch profiles, replace only that symlink:

```bash
unlink ~/.config/opencode
ln -s ~/.dotfiles/opencode/shotgun ~/.config/opencode
```

Change the final source path to `gptgrok`, `gptsetup`, `meridian`, or
`shotgun` for the desired profile. Restart OpenCode after switching so plugins,
providers, agents, and MCP servers are reloaded.

Verify the active profile and shared skills link with:

```bash
readlink ~/.config/opencode
readlink ~/.config/opencode/skills
```

## Configuration Responsibilities

- `opencode.json` configures the default model, enabled providers, plugins, and
  MCP servers.
- `oh-my-openagent.json` configures orchestration agents, category routing,
  concurrency, and plugin behavior.
- `agents/*.md` defines local agents, permissions, prompts, and any explicit
  model fallbacks needed by the active profile.
- `skills/` exposes the shared reusable workflows.
- `tasks/` contains profile-local runtime task state and is not shared.

Some MCP entries contain machine-specific executable paths, local service URLs,
or credentials. Review `opencode.json` before using a profile on another
machine, keep secrets out of documentation, and prefer environment variables
for credentials.

Shotgun is a hybrid profile. It keeps GPT 5.6 Sol as the default model and keeps
the GPT Grok MCP and agent surface, but routes Sisyphus normal and ultrawork
orchestration to Claude Opus 4.8 through the same local Anthropic bridge used by
Meridian at `http://127.0.0.1:3456`. Both Claude-capable profiles load
`./plugin/meridian.ts` for session tracking and subagent model selection.

On this machine, set `MERIDIAN_CLAUDE_PATH=$HOME/.local/bin/claude` so Meridian
uses the native arm64 Claude Code binary instead of the Rosetta x64 bundle.

See each profile README for its provider and model details:

- [GPT Grok setup](gptgrok/README.md)
- [GPT setup](gptsetup/README.md)
- [Meridian setup](meridian/README.md)
- [Shotgun setup](shotgun/README.md)
