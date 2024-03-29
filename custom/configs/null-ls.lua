local null_ls = require "null-ls"
local b = null_ls.builtins
local svelte = require "null-ls".builtins.formatting.prettier.with {
  filetypes = { "svelte" },
}
svelte.filetypes = { "svelte" }

local sources = {
  -- webdev stuff
  b.formatting.deno_fmt,                                                    -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  b.diagnostics.eslint,
}


null_ls.setup {
  debug = true,
  svelte = svelte,
  sources = sources,
}

-- Additional on_attach configuration
vim.api.nvim_exec([[
  augroup LspFormatting
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
  augroup END
]], false)
