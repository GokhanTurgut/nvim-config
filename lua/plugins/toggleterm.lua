return {
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
}
