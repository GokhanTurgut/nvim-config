return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 180,
    },
    keys = {
      { "<leader>z", "<cmd>NoNeckPain<cr>", desc = "NoNeckPain" },
    },
  },

  {
    -- Theme
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
}
