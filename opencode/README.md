# OpenCode Configurations

This directory contains two selectable OpenCode configurations. Each profile has
its own provider, model, plugin, MCP, and agent settings while sharing the skill
library in `opencode/skills/`.

## Profiles

| Profile | Default model | Use it when |
| --- | --- | --- |
| [`gptsetup/`](gptsetup/README.md) | `openai/gpt-5.6-sol` | OpenAI should be the primary model family, with xAI available for selected review and reasoning roles. |
| [`meridian/`](meridian/README.md) | `anthropic/claude-sonnet-4-6` | Anthropic should be the primary model family through the local `opencode-with-claude` provider bridge. |

The top-level `opencode/` directory is a container for these profiles; it is not
itself the active OpenCode configuration. Link one profile to
`~/.config/opencode`.

## Shared and Profile-Specific Files

```text
opencode/
├── skills/                 # Shared skill definitions
├── gptsetup/
│   ├── agents/             # OpenAI-oriented agent definitions
│   ├── skills -> ../skills # Shared skill symlink
│   ├── opencode.json
│   └── oh-my-openagent.json
└── meridian/
    ├── agents/             # Anthropic-oriented agent definitions
    ├── skills -> ../skills # Shared skill symlink
    ├── opencode.json
    └── oh-my-openagent.json
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

### OpenAI profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/gptsetup ~/.config/opencode
```

### Meridian profile

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/meridian ~/.config/opencode
```

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
ln -s ~/.dotfiles/opencode/meridian ~/.config/opencode
```

Change the final source path to `gptsetup` to switch back. Restart OpenCode
after switching so plugins, providers, agents, and MCP servers are reloaded.

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

See each profile README for its provider and model details:

- [GPT setup](gptsetup/README.md)
- [Meridian setup](meridian/README.md)
