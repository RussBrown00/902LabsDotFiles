# OpenCode Shotgun Setup

Shotgun is a hybrid OpenCode profile. It keeps GPT 5.6 Sol as the default model
for normal direct use, then routes Sisyphus normal and ultrawork orchestration to
Claude Opus 4.8 through the Meridian Anthropic bridge.

See the [parent OpenCode README](../README.md) for profile selection, symlink
installation, and switching instructions.

## Configuration Summary

- **Default model:** `openai/gpt-5.6-sol`
- **Claude orchestration model:** Claude Opus 4.8 for Sisyphus normal and
  ultrawork routing
- **Enabled providers:** OpenAI, xAI, OpenCode, and Anthropic through the local
  Meridian bridge
- **Plugins:** `./plugin/meridian.ts` (session headers), `opencode-with-claude`, `oh-my-openagent@latest`, and last-loaded `./plugin/block-oh-my-claude.ts` (hard-stop guard)
- **oh-my-claude defense-in-depth:** declarative `tools` hide and `permission` deny for `*oh-my-claude*`, `*oh_my_claude*`, `*ohmyclaude*`, `*oh my claude*`, and `*oh.my.claude*`; last-loaded plugin hard-stops on `tool.execute.before` for any remaining match of `oh` + optional/repeated `[-_.\s]` + `my` + optional/repeated `[-_.\s]` + `claude` (covers repeated separators the wildcards omit). Preserves `oh-my-openagent`, `opencode-with-claude`/Meridian, and plain Claude model IDs.
- **Anthropic bridge:** `http://127.0.0.1:3456`
- **Shared skills:** `skills -> ../skills`
- **Inherited surface:** GPT Grok MCP entries and profile-local agents are
  preserved unless explicitly overridden

Profile creation in this repository does not activate Shotgun. OpenCode loads it
only after `~/.config/opencode` points at `~/.dotfiles/opencode/shotgun` and the
app has been restarted.

## Requirements

Start Meridian before OpenCode (or let `opencode-with-claude` start it). The
Anthropic provider expects that service at `http://127.0.0.1:3456`.

Set `MERIDIAN_CLAUDE_PATH` to the native Claude Code binary (see `~/.zshrc`).
On Apple Silicon, avoid Meridian's bundled x64 Claude binary under Rosetta.

## Install This Profile

From a repository cloned to `~/.dotfiles`:

```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode/shotgun ~/.config/opencode
cd ~/.config/opencode
npm install
```

If `~/.config/opencode` already exists, back it up or unlink it before creating
the new symlink. Do not run `ln -s` over an existing configuration directory.

## File Responsibilities

- `opencode.json` keeps GPT 5.6 Sol as the default model, enables the hybrid
  provider set, loads plugins (guard last), defines MCP servers, and applies
  declarative `tools=false` / `permission=deny` wildcards for common oh-my-claude
  spellings (hyphen, underscore, concatenated, spaced, dotted) so those tools
  are hidden and denied before the model sees them.
- `plugin/block-oh-my-claude.ts` is the last-loaded enforcement layer: pure
  matcher + `tool.execute.before` hard-stop for any remaining oh-my-claude*
  tool/MCP name, including repeated separators (`oh__my__claude`, `oh--my--…`)
  and dotted forms. Does not use `tool.definition` as a fake unregister.
- `plugin/meridian.ts` injects Anthropic session/agent headers for the local bridge.
- `oh-my-openagent.json` routes Sisyphus normal and ultrawork orchestration to
  Claude Opus 4.8 through the Meridian Anthropic bridge.
- `agents/*.md` preserves the GPT Grok agent surface unless a Shotgun-specific
  override is needed.
- `skills` is a relative symlink to the parent `opencode/skills/` directory.

Restart OpenCode after any change to `opencode.json`, plugins, agents, providers,
or MCP entries — config is loaded only at startup.

## Machine-Specific Setup

Before starting OpenCode, review the MCP entries in `opencode.json`:

- The Claude provider bridge expects a local service on port `3456`.
- Preserved GPT Grok MCP servers may include local paths, remote OAuth flows,
  Docker services, or credential-backed tools.
- The shared skills symlink must continue to resolve through `../skills`.

Update local paths for the current machine and provide credentials through
environment variables rather than committing or documenting secret values.

## Verify

```bash
readlink ~/.config/opencode
readlink ~/.config/opencode/skills
```

The first command should end in `opencode/shotgun`; the second should resolve
through the profile's `../skills` link. Restart OpenCode after configuration,
agent, provider, plugin, or MCP changes.
