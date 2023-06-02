local plugins = {
  {
  'wakatime/vim-wakatime',
    config = function()
      vim.g.wakatime_api_key = ''
      vim.g.wakatime_python = '/usr/bin/python'
    end
  },
  {
  "neovim/nvim-lspconfig",
   dependencies = {
     "jose-elias-alvarez/null-ls.nvim",
     config = function()
       require "custom.configs.null-ls"
     end,
   },
   config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
   end
  }
}

return plugins
