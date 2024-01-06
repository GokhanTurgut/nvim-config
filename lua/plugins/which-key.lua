return {
  "folke/which-key.nvim",
  config = function()
    -- document existing key chains
    require("which-key").register({
      ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
      ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
      ["<leader>l"] = { name = "LSP", _ = "which_key_ignore" },
      ["<leader>b"] = { name = "Buffers", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "Harpoon", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "Session", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "Terminal", _ = "which_key_ignore" },
    })
  end,
}
