return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    -- {"<leader>/", false},
    -- change a keymap
    { "<leader>ss", false },
    -- add a keymap to browse plugin files
    -- {
    --   "<leader>fp",
    --   function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
    --   desc = "Find Plugin File",
    -- },
  },
  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  },
}
