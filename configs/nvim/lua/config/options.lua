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

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   -- paste = {
--   --   ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--   --   ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--   -- },
-- }
--
-- -- vim.g.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- vim.opt.clipboard = "unnamedplus"
--

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
