local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
  },
  opts = {
    view = {
      width = 40,
    },
    update_focused_file = {
      enable = true,
    },
  },
  config = function()
    require("nvim-tree").setup({ on_attach = my_on_attach })
  end,
}
