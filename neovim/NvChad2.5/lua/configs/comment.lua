local c = require "Comment"
local ft = require "Comment.ft"

ft.set("terraform", "#%s")
ft({ "go", "rust" }, ft.get "c")
ft({ "toml", "graphql" }, "#%s")

c.setup {
  padding = true,
}
