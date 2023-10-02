return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "scala",
        "toml",
      },
    },
    {
      "neovim/nvim-lspconfig",
      init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        -- disable a keymap
        keys[#keys + 1] = { "K", false }
      end,
    },
  },
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
  -- {
  --   "mfussenegger/nvim-dap",
  -- },
  -- {
  --   "scalameta/nvim-metals",
  --   dependencies = { "nvim-lua/plenary.nvim", sg "mfussenegger/nvim-dap" },
  -- },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
  -- {
  --   -- "jose-elias-alvarez/null-ls.nvim",
  --   "nvimtools/none-ls.nvim",
  --   require("none-ls").setup({
  --     sources = {
  --       require("none-ls").builtins.formatting.prettier,
  --       require("none-ls").builtins.formatting.prettier.with({
  --         filetypes = { "javascript", "typescript", "json", "yaml", "html", "css", "scss", "markdown" },
  --       }),
  --     },
  --   }),
  -- },
}
