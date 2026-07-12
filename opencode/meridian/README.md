# OpenCode Meridian Setup

Meridian is the Anthropic-oriented OpenCode profile. It uses Claude for the
default model and most orchestration roles while retaining OpenAI and xAI for
selected cross-model tasks.

See the [parent OpenCode README](../README.md) for profile selection, symlink
installation, and switching instructions.

## Configuration Summary

- **Default model:** `anthropic/claude-sonnet-4-6`
- **Enabled providers:** Anthropic, OpenAI, xAI, and `claude-max`
- **Plugins:** `opencode-with-claude` and `oh-my-openagent@latest`
- **Anthropic bridge:** `http://127.0.0.1:3456`
- **Shared skills:** `skills -> ../skills`
- **Local agents:** `argus`, `clio`, and `git-operator`

The routing in `oh-my-openagent.json` uses Claude Sonnet for orchestration and
general deep work, Claude Opus for implementation and high-reasoning roles, and
Claude Haiku for lightweight search and Git tasks. OpenAI remains assigned to
selected cross-model roles such as Argus and writing.

## Requirements

Start the local service used by `opencode-with-claude` before OpenCode. The
Anthropic provider in `opencode.json` expects that service at
`http://127.0.0.1:3456`.

## Install This Profile

From a repository cloned to `~/.dotfiles`:

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/meridian ~/.config/opencode
cd ~/.config/opencode
npm install
```

If `~/.config/opencode` already exists, back it up or unlink it before creating
the new symlink. Do not run `ln -s` over an existing configuration directory.

## File Responsibilities

- `opencode.json` configures the Claude provider bridge, default model, plugins,
  enabled providers, and MCP servers.
- `oh-my-openagent.json` maps orchestration agents and task categories to their
  intended models and reasoning variants.
- `agents/*.md` supplies explicit, profile-local agent definitions.
- `skills` is a relative symlink to the parent `opencode/skills/` directory.

## Why This Profile Has Agent Files

Model assignments in `oh-my-openagent.json` are the central routing map, but
the plugin does not always apply those assignments to every direct or custom
agent invocation. The files in `agents/` keep agent behavior profile-local and
allow model declarations to be added at the agent-file level when plugin-only
routing is unreliable. The current `git-operator` file explicitly selects its
Meridian model; the other local agents still take their model routing from
`oh-my-openagent.json`.

When changing `argus`, `clio`, or `git-operator`, keep its model declaration and
instructions consistent with the corresponding entry in
`oh-my-openagent.json`. The shared skill definitions should be edited only in
`../skills/`.

## Machine-Specific Setup

Before starting OpenCode, review the MCP entries in `opencode.json`:

- The Claude provider bridge expects a local service on port `3456`.
- Figma expects a local MCP service on port `3845`.
- Postmark template sync points to a local Node project and requires a server
  token.
- Honeybadger runs through Docker and requires a personal authentication token.

Update local paths for the current machine and provide credentials through
environment variables rather than committing new secrets.

## Verify

```bash
readlink ~/.config/opencode
readlink ~/.config/opencode/skills
```

The first command should end in `opencode/meridian`; the second should resolve
through the profile's `../skills` link. Restart OpenCode after configuration or
agent changes.
