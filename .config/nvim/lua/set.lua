
-- for neo-tree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.g.relativenumber = 1


vim.opt.nu = true
vim.opt.rnu = true

-- tabs

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- visual clues
vim.opt.cursorline = true

vim.diagnostic.config({ virtual_text = true })
vim.opt.listchars = {
  eol = '$',
  tab = '=>',
  trail = '█'
}
vim.opt.list = true


-- vim.g.python_recommended_style = 0
---


vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hls = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true


-- vim.opt.nocompatible = true
-- vim.opt.syntax = true
-- filetype plugin on


