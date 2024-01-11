return {
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
}
