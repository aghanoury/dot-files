return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "storm" },
    require("tokyonight").setup({
      -- use the night style
      on_colors = function(colors)
        colors.border = colors.orange
        -- make the normal text a bit more high contrast
        colors.fg = "#fefefe"
      end,
    }),
  },
  -- Or with configuration
  -- {
  --   'projekt0n/caret.nvim',
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('caret').setup({
  --       -- ...
  --     })
  --
  --     vim.cmd('colorscheme caret')
  --   end,
  -- }
}
