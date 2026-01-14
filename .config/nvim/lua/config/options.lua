vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Disable Copilot tab mapping
vim.g.copilot_no_tab_map = true

local have_nerd_font = true
local env = vim.env.NVIM_HAVE_NERD_FONT
if env == "0" or env == "false" then
  have_nerd_font = false
end
vim.g.have_nerd_font = have_nerd_font

vim.o.mouse = "a"
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.hidden = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.inccommand = "split"

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

vim.o.undofile = true

vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.colorcolumn = "120"
