-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("set")
require("remap")
--require("toc")

-- Setup lazy.nvim
require("lazy").setup({
    -- highlight-start
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- highlight-end
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


vim.opt.rtp:prepend(lazypath)

require("lsp")

plugins = {
}

opts = {
}

-- local lspconfig = require 'lspconfig'
-- local configs = require 'lspconfig/configs'

-- require('lspconfig').ltex_plus.setup {
--   settings = {
--     ltex = {
--       -- language = "en"
--       -- language = "de-DE"
--       language = "fr";
--     }
--   },
--   filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc", "tex" },
--   -- flags = { debounce_text_changes = 300 },
--   -- on_attach = on_attach,
-- }
