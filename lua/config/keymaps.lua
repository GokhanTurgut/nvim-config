-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

-- Leader key disable
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Escape with jk
vim.keymap.set({ "i" }, "jk", "<esc>")

-- Better half page navigation
vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz")

-- Easy quit and write
vim.keymap.set({ "n" }, "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set({ "n" }, "<leader>w", "<cmd>w<cr>", { desc = "Write" })

-- Yank relative path
vim.keymap.set({ "n" }, "<leader>y", "<cmd>let @+ = expand('%:.')<cr>", { desc = "Yank relative path" })
vim.keymap.set({ "n" }, "<leader>Y", "<cmd>let @+ = expand('%:t')<cr>", { desc = "Yank name" })

-- Better indentation
vim.keymap.set({ "v" }, "<", "<gv")
vim.keymap.set({ "v" }, ">", ">gv")

-- Create windows
vim.keymap.set({ "n" }, "<leader>\\", "<C-W>s", { desc = "Split horizontally", remap = true })
vim.keymap.set({ "n" }, "<leader>|", "<C-W>v", { desc = "Split vertically", remap = true })

-- Move between windows
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set({ "n" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set({ "n" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set({ "n" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set({ "n" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Diagnostic" })
vim.keymap.set("n", "<leader>lD", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
