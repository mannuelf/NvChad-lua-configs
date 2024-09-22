vim.g.dap_virtual_text = true

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

local custom_plugins = {
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  "nvim-lua/plenary.nvim",
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup {
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "tsx",
          "vue",
          "svelte",
          "php",
          "markdown",
          "rust",
          "tsx",
        },
      }
    end,
    lazy = false,
  },
  {
    "git@github.com:github/copilot.vim",
    config = function()
      vim.cmd "Copilot enable"
    end,
    lazy = false, -- Ensure Copilot loads on startup
  },
}

-- Load the custom plugins
require("lazy").setup(custom_plugins)
