return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        path_display = { truncate = 3 },
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
          },
        },
      },
    })
    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    -- Enable telescope grep args, if installed
    pcall(require("telescope").load_extension("live_grep_args"))
    -- Enable telescope undo, if installed
    require("telescope").load_extension("undo")

    -- Gets the visually selected text for using it in grep
    local function getVisualSelection()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg("v")
      vim.fn.setreg("v", {})

      text = string.gsub(text, "\n", "")
      if #text > 0 then
        return text
      else
        return ""
      end
    end

    local tb = require("telescope.builtin")

    vim.keymap.set("n", "<leader>r", tb.oldfiles, { desc = "Recently opened files" })
    vim.keymap.set("n", "<leader><space>", tb.buffers, { desc = "Find existing buffers" })
    vim.keymap.set(
      "n",
      "<leader>/",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Grep" }
    )
    vim.keymap.set("v", "<space>/", function()
      require("telescope").extensions.live_grep_args.live_grep_args({ default_text = getVisualSelection() })
    end, { desc = "Live grep selected text" })
    vim.keymap.set("n", "<leader>ff", tb.git_files, { desc = "Git Files" })
    vim.keymap.set("n", "<leader>fF", tb.find_files, { desc = "Files" })
    vim.keymap.set("n", "<leader>fg", tb.grep_string, { desc = "Grep string" })
    vim.keymap.set("v", "<space>fg", function()
      tb.grep_string({ default_text = getVisualSelection() })
    end, { desc = "Grep selected text" })
    vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Help" })
    vim.keymap.set("n", "<leader>fd", tb.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>R", tb.resume, { desc = "Resume search" })
    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undo Tree" })
  end,
}
