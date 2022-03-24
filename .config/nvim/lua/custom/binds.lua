local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move between splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Split resizing
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tab navigation
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Escape insert mode
keymap("i", "jk", "<ESC>", opts)

-- Indent selection
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Telescope
keymap("n", "<leader>gr", [[<cmd>Telescope lsp_references<CR>]], opts)
keymap("n", "<leader>ff", [[<cmd>Telescope find_files<CR>]], opts)
keymap("n", "<leader>fg", [[<cmd>Telescope live_grep<CR>]], opts)
keymap("n", "<leader>fh", [[<cmd>Telescope help_tags<CR>]], opts)

-- Formatting
keymap("n", "<leader>fm", [[<cmd>lua vim.lsp.buf.formatting()<cr>]], opts)
