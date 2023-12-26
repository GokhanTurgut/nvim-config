-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration files
require("config")

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "catppuccin-mocha" },
  },
  rtp = {
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrw",
      "netrwPlugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ln", vim.lsp.buf.rename, "Rename")
  nmap("<leader>la", vim.lsp.buf.code_action, "Code action")

  nmap("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto references")
  nmap("gm", require("telescope.builtin").lsp_implementations, "Goto implementation")
  nmap("<leader>gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
  nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
  nmap("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Dynamic Symbols")
  nmap("<leader>lW", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
  nmap("<leader>le", "<cmd>EslintFixAll<cr>", "Eslint Fix All")
  nmap("<leader>lo", function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports.ts" },
        diagnostics = {},
      },
    })
  end, "TS Organize Imports")
  nmap("<leader>lr", "<cmd>LspRestart<cr>", "Restart LSP")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("J", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "Goto declaration")
end

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

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

-- Setup neovim lua configuration
require("neodev").setup()

require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- Setup manually installed LSPs
lspconfig.rubocop.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "ruby" },
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
})

lspconfig.sorbet.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "ruby" },
  cmd = { "bundle", "exec", "srb", "typecheck", "--lsp" },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
})
