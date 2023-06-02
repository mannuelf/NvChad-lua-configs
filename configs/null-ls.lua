local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,
  formatting.svelte,
  formatting.typescript,
  formatting.html,
  formatting.javascript,
  formatting.lua,
  formatting.dart,

  lint.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
