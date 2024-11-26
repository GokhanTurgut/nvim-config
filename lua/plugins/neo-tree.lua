return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree reveal toggle<cr>", desc = "Neotree" },
    { "<leader>E", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 42,
        mappings = {
          ["l"] = "open",
          ["L"] = "focus_preview",
          ["h"] = "close_node",
          ["H"] = "close_all_nodes",
        },
      },
    })
  end,
}
