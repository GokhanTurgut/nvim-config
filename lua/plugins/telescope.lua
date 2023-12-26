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

    vim.keymap.set("n", "<leader>r", require("telescope.builtin").oldfiles, { desc = "Recently opened files" })
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Find existing buffers" })
    vim.keymap.set(
      "n",
      "<leader>/",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Grep" }
    )
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").git_files, { desc = "Git Files" })
    vim.keymap.set("n", "<leader>fF", require("telescope.builtin").find_files, { desc = "Files" })
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help" })
    vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>R", require("telescope.builtin").resume, { desc = "Resume search" })
  end,
}
