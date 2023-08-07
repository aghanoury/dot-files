-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- local opts = { noremap = true, silent = true }
--
-- local term_opts = { silent = true }
-- local keymap = vim.api.nvim_set_keymap
--
-- -- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",
--
-- keymap("n", "<S-j>", "<C-e>", opts)
-- keymap("n", "<S-k>", "<C-y>", opts)
--

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height", remap = true })
map("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- other movement stuff
-- remap buffer moving
map("n", "<C-S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer", remap = true })
map("n", "<C-S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer", remap = true })

-- remove old LSP keymap

-- remap S-h/i to jump words
map({ "n", "v" }, "<S-h>", "b", { desc = "move back a word" })
map({ "n", "v" }, "<S-l>", "e", { desc = "move forward a word" })
map({ "n", "v" }, "J", "<C-e>", { desc = "move window down a line", remap = true })
map({ "n", "v" }, "K", "<C-y>", { desc = "move window up a line", remap = true })

-- delete full word on delete
map("i", "<A-BS>", "<C-w>", { desc = "Delete preceding word", remap = true })
