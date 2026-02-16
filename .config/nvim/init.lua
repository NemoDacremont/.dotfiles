-- Required to build telescope-fzf-native
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        -- Run build script after plugin's code has changed
        if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
            -- Append `:wait()` if you need synchronous execution
            vim.system({ 'make' }, { cwd = ev.data.path })
        end
    end
})

-- Remap leader as soon as possible
vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>po", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim.git",                        version = "stable" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git",          version = "v0.10.0" },
    { src = "https://github.com/nvim-telescope/telescope.nvim.git",            version = "v0.2.1" },
    { src = "https://github.com/nvim-lua/plenary.nvim.git",                    version = "v0.1.4" },                 -- Telescope dep
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git", version = "main",   build = "make" }, -- Telescope dep
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git",              version = "v0.100" },                 -- Telescope dep
    { src = 'https://github.com/neovim/nvim-lspconfig' },  -- Basic config for LSP
    { src = "https://github.com/mason-org/mason.nvim.git",                     version = 'v2.2.1' },  -- Download LSP easily
    { src = "https://github.com/mason-org/mason-lspconfig.nvim.git", version = "v2.1.0" },  -- Auto enable LSP from mason
    { src = "https://github.com/ribru17/bamboo.nvim.git" },
})

require("oil").setup({
    view_options = {
        show_hidden = true,
    },
    columns = {
        "icon",
    },
})

require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})

require("mason").setup()
require("mason-lspconfig").setup()
vim.opt.termguicolors = true
vim.cmd("colorscheme bamboo")

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'popup' }
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() ~= 0 then return "<C-n>" end
    return "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() ~= 0 then return "<C-p>" end
    return "<S-Tab>"
end, { expr = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
  if vim.fn.pumvisible() ~= 0 then return "<C-e><CR>" end
  return "<CR>"
end, { expr = true })


-- for neo-tree
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
vim.opt.winborder = "rounded"

vim.diagnostic.config({ virtual_text = true })
vim.opt.listchars = {
    eol = '$',
    tab = '=>',
    trail = '█'
}
vim.opt.list = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.ignorecase = true

vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
