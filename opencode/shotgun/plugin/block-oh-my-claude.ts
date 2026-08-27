/**
 * Defense-in-depth guard: hard-stop any tool whose name matches oh-my-claude
 * variants before execution (hyphen, underscore, dot, whitespace, repeated
 * separators, or concatenated).
 *
 * Declarative hide/deny layers live in opencode.json (`tools` + `permission`).
 * This plugin is the last-loaded enforcement layer and must not be bypassed
 * via tool.definition tricks. Repeated separators are guaranteed here even
 * when declarative wildcards only list common spellings.
 */
import type { Plugin } from "@opencode-ai/plugin"

/**
 * True when `name` contains the sequence:
 *   oh + zero-or-more [-_.\s] + my + zero-or-more [-_.\s] + claude
 * Case-insensitive. Matches mcp__plugin_oh-my-claudecode_*, oh_my_claudecode,
 * ohmyclaude, oh__my__claude, oh.my.claude, oh--my--claudecode, etc.
 * Does not match oh-my-openagent or bare "claude".
 */
export function isBlockedOhMyClaudeToolName(name: string): boolean {
  return /oh[-_.\s]*my[-_.\s]*claude/i.test(name)
}

const BlockOhMyClaudePlugin: Plugin = async () => {
  return {
    "tool.execute.before": async (input) => {
      if (!isBlockedOhMyClaudeToolName(input.tool)) {
        return
      }

      throw new Error(
        `Blocked tool "${input.tool}": oh-my-claude tools/MCPs are disabled in this OpenCode profile (defense-in-depth guard).`,
      )
    },
  }
}

export default BlockOhMyClaudePlugin
