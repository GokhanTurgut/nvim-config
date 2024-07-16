return {
  "folke/which-key.nvim",
  dependencies = "echasnovski/mini.icons",
  config = function()
    -- document existing key chains
    require("which-key").add({
      { "<leader>b", group = "Buffers" },
      { "<leader>b_", hidden = true },
      { "<leader>g", group = "Git" },
      { "<leader>g_", hidden = true },
      { "<leader>h", group = "Harpoon" },
      { "<leader>h_", hidden = true },
      { "<leader>s", group = "Session" },
      { "<leader>s_", hidden = true },
      { "<leader>t", group = "Terminal" },
      { "<leader>t_", hidden = true },
      {
        mode = { "n", "v" },
        { "<leader>f", group = "Find" },
        { "<leader>f_", hidden = true },
        { "<leader>l", group = "LSP" },
        { "<leader>l_", hidden = true },
      },
    })
  end,
}
