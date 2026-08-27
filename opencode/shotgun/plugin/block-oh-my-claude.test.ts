import { describe, expect, test } from "bun:test"
import BlockOhMyClaudePlugin, {
  isBlockedOhMyClaudeToolName,
} from "./block-oh-my-claude"

describe("isBlockedOhMyClaudeToolName", () => {
  const blocked = [
    "oh-my-claude",
    "oh_my_claude",
    "oh my claude",
    "ohmyclaude",
    "Oh-My-Claude",
    "OH_MY_CLAUDE",
    "oh__my__claude",
    "oh.my.claude",
    "oh--my--claudecode",
    "mcp__plugin_oh-my-claudecode_session",
    "mcp__plugin_oh-my-claudecode_status",
    "mcp__plugin_ohmyclaudecode_session",
    "mcp__plugin_ohmyclaudecode_status",
    "plugin_oh_my_claudecode_foo",
    "prefix-oh-my-claude-suffix",
    "oh-my-claudecode",
    "ohmyclaudecode_tool",
  ]

  const allowed = [
    "oh-my-openagent",
    "oh_my_openagent",
    "opencode-with-claude",
    "claude-sonnet-4-6",
    "anthropic/claude-opus-4-8",
    "claude",
    "figma",
    "shortcut",
    "honeybadger",
    "bash",
    "read",
    "edit",
    "mcp__figma__get_design_context",
    "mcp__shortcut__stories-search",
    "mcp__honeybadger__list_projects",
    "oh-my-openagent@latest",
    "meridian",
    "postmark-template-sync",
    "drawio-generator",
  ]

  for (const name of blocked) {
    test(`blocks ${JSON.stringify(name)}`, () => {
      expect(isBlockedOhMyClaudeToolName(name)).toBe(true)
    })
  }

  for (const name of allowed) {
    test(`allows ${JSON.stringify(name)}`, () => {
      expect(isBlockedOhMyClaudeToolName(name)).toBe(false)
    })
  }
})

describe("tool.execute.before hook (simulated)", () => {
  async function getBeforeHook() {
    const hooks = await BlockOhMyClaudePlugin({} as never)
    const before = hooks["tool.execute.before"]
    if (!before) {
      throw new Error("expected tool.execute.before hook")
    }
    return before
  }

  function callInput(tool: string) {
    return {
      tool,
      sessionID: "ses_test",
      callID: "call_test",
    }
  }

  const emptyOutput = { args: {} }

  test("throws on mcp__plugin_oh-my-claudecode_* without invoking a real tool", async () => {
    const before = await getBeforeHook()
    await expect(
      before(callInput("mcp__plugin_oh-my-claudecode_session"), emptyOutput),
    ).rejects.toThrow(/Blocked tool/)
  })

  test("throws on oh_my_claudecode variant", async () => {
    const before = await getBeforeHook()
    await expect(
      before(callInput("oh_my_claudecode_status"), emptyOutput),
    ).rejects.toThrow(/oh-my-claude/)
  })

  test("throws on concatenated ohmyclaude", async () => {
    const before = await getBeforeHook()
    await expect(before(callInput("ohmyclaude"), emptyOutput)).rejects.toThrow(
      /disabled/,
    )
  })

  test("throws on repeated/dotted separators without invoking a real tool", async () => {
    const before = await getBeforeHook()
    for (const tool of [
      "oh__my__claude",
      "oh.my.claude",
      "oh--my--claudecode",
      "mcp__plugin_ohmyclaudecode_session",
    ]) {
      await expect(before(callInput(tool), emptyOutput)).rejects.toThrow(
        /Blocked tool/,
      )
    }
  })

  test("allows bash without throwing", async () => {
    const before = await getBeforeHook()
    await expect(before(callInput("bash"), emptyOutput)).resolves.toBeUndefined()
  })

  test("allows oh-my-openagent without throwing", async () => {
    const before = await getBeforeHook()
    await expect(
      before(callInput("oh-my-openagent"), emptyOutput),
    ).resolves.toBeUndefined()
  })

  test("allows opencode-with-claude without throwing", async () => {
    const before = await getBeforeHook()
    await expect(
      before(callInput("opencode-with-claude"), emptyOutput),
    ).resolves.toBeUndefined()
  })

  test("allows figma / shortcut / honeybadger / read / edit", async () => {
    const before = await getBeforeHook()
    for (const tool of [
      "figma",
      "shortcut",
      "honeybadger",
      "read",
      "edit",
      "mcp__figma__get_screenshot",
    ]) {
      await expect(before(callInput(tool), emptyOutput)).resolves.toBeUndefined()
    }
  })
})
