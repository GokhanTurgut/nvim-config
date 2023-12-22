return {
  -- Harpoon
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    menu = {
      width = 160,
      height = 20,
    },
  },
  keys = {
    { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file" },
    { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next" },
    { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous" },
    { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon marks" },
    { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "which_key_ignore" },
    { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "which_key_ignore" },
    { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "which_key_ignore" },
    { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "which_key_ignore" },
    { "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "which_key_ignore" },
    { "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "which_key_ignore" },
    { "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "which_key_ignore" },
    { "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "which_key_ignore" },
    { "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "which_key_ignore" },
  },
}
