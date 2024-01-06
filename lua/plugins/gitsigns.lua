return {
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
}
