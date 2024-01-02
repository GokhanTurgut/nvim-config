return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { "folke/neodev.nvim", opts = {} },
    },
    keys = {
      { "<leader>lI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      { "<leader>lL", "<cmd>LspLog<cr>", desc = "LSP Logs" },
      { "<leader>lM", "<cmd>Mason<cr>", desc = "Mason" },
    },
    config = function()
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

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        cmd = { "typescript-language-server", "--stdio" },
        root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
        single_file_support = true,
        init_options = {
          hostInfo = "neovim",
        },
      })
    end,
  },
}
