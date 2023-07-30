return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "stylua",
  --       "shellcheck",
  --       "shfmt",
  --       "flake8",
  --     },
  --   },
  -- },
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", }
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    dependencies = {
      "williamboman/mason.nvim"
    },
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},

      },
    },
  },
}
