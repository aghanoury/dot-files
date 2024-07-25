return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   opts = { style = "storm" },
  --   require("tokyonight").setup({
  --     -- use the night style
  --     on_colors = function(colors)
  --       colors.border = colors.orange
  --       -- make the normal text a bit more high contrast
  --       colors.fg = "#fefefe"
  --     end,
  --   }),
  -- },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({})
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
