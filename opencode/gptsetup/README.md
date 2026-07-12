# OpenCode GPT Setup

This profile makes OpenAI the primary OpenCode model family. It is the default
choice when GPT models should handle orchestration and implementation while xAI
models remain available for selected reasoning and review roles.

See the [parent OpenCode README](../README.md) for profile selection, symlink
installation, and switching instructions.

## Configuration Summary

- **Default model:** `openai/gpt-5.6-sol`
- **Enabled providers:** OpenAI and xAI
- **Plugins:** `oh-my-openagent@latest`
- **Shared skills:** `skills -> ../skills`
- **Local agents:** `argus`, `clio`, and `git-operator`

The routing in `oh-my-openagent.json` uses GPT models for the main Sisyphus and
Hephaestus agents, lightweight GPT models for search and Git work, and xAI
models for selected high-reasoning categories and reviewers.

## Install This Profile

From a repository cloned to `~/.dotfiles`:

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/gptsetup ~/.config/opencode
cd ~/.config/opencode
npm install
```

If `~/.config/opencode` already exists, back it up or unlink it before creating
the new symlink. Do not run `ln -s` over an existing configuration directory.

## File Responsibilities

- `opencode.json` selects the default GPT model, enables providers, loads the
  OpenAgent plugin, and defines MCP servers.
- `oh-my-openagent.json` maps orchestration agents and task categories to their
  intended models and reasoning variants.
- `agents/*.md` supplies explicit, profile-local agent definitions.
- `skills` is a relative symlink to the parent `opencode/skills/` directory.

## Why This Profile Has Agent Files

Model assignments in `oh-my-openagent.json` are the central routing map, but
the plugin does not always apply those assignments to every direct or custom
agent invocation. The files in `agents/` intentionally repeat model-sensitive
configuration and declare GPT models in their frontmatter for this profile.

When changing `argus`, `clio`, or `git-operator`, keep its model declaration and
instructions consistent with the corresponding entry in
`oh-my-openagent.json`. The shared skill definitions should be edited only in
`../skills/`.

## Machine-Specific Setup

Before starting OpenCode, review the MCP entries in `opencode.json`:

- Figma expects a local MCP service on port `3845`.
- Draw.io uses `uvx` with Python 3.12.
- Postmark template sync points to a local Node project and requires a server
  token.

Update local paths for the current machine and provide credentials through
environment variables rather than committing new secrets.

## Verify

```bash
readlink ~/.config/opencode
readlink ~/.config/opencode/skills
```

The first command should end in `opencode/gptsetup`; the second should resolve
through the profile's `../skills` link. Restart OpenCode after configuration or
agent changes.
