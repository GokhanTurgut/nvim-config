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
    "echasnovski/mini.files",
    version = "*",
    opts = {
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = false,
      },
      windows = {
        -- Width of focused window
        width_focus = 60,
        -- Width of non-focused window
        width_nofocus = 20,
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Minifiles",
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm size=90 direction=vertical<cr>", desc = "Terminal vertical" },
      { "<leader>th", "<cmd>ToggleTerm size=20 direction=horizontal<cr>", desc = "Terminal horizontal" },
      {
        "<leader>tr",
        "<cmd>TermExec cmd='bundle exec rspec %' size=90 direction=vertical<cr>",
        desc = "Run Rspec for the buffer",
      },
      {
        "<leader>tj",
        "<cmd>TermExec cmd='yarn jest %' size=90 direction=vertical<cr>",
        desc = "Run Jest for the buffer",
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<leader>fr",
        function()
          require("spectre").open()
        end,
        desc = "Replace (Spectre)",
      },
    },
    opts = {
      mapping = {
        ["send_to_qf"] = {
          map = "<leader>f",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
      },
    },
  },

  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>d",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>D", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
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
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  {
    "echasnovski/mini.pairs",
    version = "*",
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "VeryLazy",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
      end,
    },
  },

  {
    -- Theme inspired by Atom
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
      globalstatus = true,
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      nvim_tmux_nav.setup({
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
}
