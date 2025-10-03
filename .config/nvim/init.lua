
require("set")
require("remap")
--require("toc")

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


plugins = {
}

opts = {
}

-- require("lazy").setup(plugins, opts)
require("lazy").setup("plugins", opts)

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

require('lspconfig').ltex_plus.setup {
  settings = {
    ltex = {
      -- language = "en"
      -- language = "de-DE"
      language = "fr";
    }
  },
  filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc", "tex" },
  -- flags = { debounce_text_changes = 300 },
  -- on_attach = on_attach,
}
