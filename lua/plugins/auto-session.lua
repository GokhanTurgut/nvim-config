return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_save_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    -- restore last workspace session for current directory
    keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "Restore session" })
    -- save workspace session for current working directory
    keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session" })
  end,
}
