-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- return {
--   require("tokyonight").setup({
--     -- use the night style
--     on_colors = function(colors)
--       colors.border = colors.orange
--     end,
--   }),
-- }
vim.opt.wrap = true -- Disable line wrap
vim.opt.linebreak = true -- Wrap on word boundary
vim.opt.conceallevel = 0
