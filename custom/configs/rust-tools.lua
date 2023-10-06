local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = function(client, bufnr)
      -- Add keybinding for RustHoverActions command
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>RustHoverActions<CR>', { noremap = true, silent = true })
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importMergeBehavior = "last",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        -- Add the following line to fix the formatting_sync error
        experimental = {
          procMacro = true,
        },
      },
    },
  }
}

return options
