vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 5

require "custom.plugins"

require "custom.binds"

require "custom.cmp"

require "custom.lsp"

require "custom.telescope"
