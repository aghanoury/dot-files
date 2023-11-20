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
        "bibtex",
        "latex",
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
        texlab = {
          keys = {
            { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
          },
        },
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          vim.wo.conceallevel = 2
        end,
      })

      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    end,
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
