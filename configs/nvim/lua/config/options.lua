-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.opt.wrap = true
vim.g.tokyonight_colors = { border = "orange" }

require("tokyonight").setup({
  -- use the night style
  on_colors = function(colors)
    colors.border = colors.orange
  end,
})
