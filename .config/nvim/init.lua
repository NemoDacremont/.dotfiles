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

vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim.git',                        version = 'stable' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git',          version = 'v0.10.0' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim.git',            version = 'v0.2.1' },
    { src = 'https://github.com/nvim-lua/plenary.nvim.git',                    version = 'v0.1.4' },                 -- Telescope dep
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim.git', version = 'main',   build = 'make' }, -- Telescope dep
    { src = 'https://github.com/nvim-tree/nvim-web-devicons.git',              version = 'v0.100' },                 -- Telescope dep
    { src = 'https://github.com/neovim/nvim-lspconfig' },                                                            -- Basic config for LSP
    { src = 'https://github.com/mason-org/mason.nvim.git',                     version = 'v2.2.1' },                 -- Download LSP easily
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim.git',           version = 'v2.1.0' },                 -- Auto enable LSP from mason
    { src = 'https://github.com/ribru17/bamboo.nvim.git' },
    { src = 'https://github.com/saghen/blink.cmp.git',                         version = 'v1.9.1' }                  -- Better auto-complete
})

require('oil').setup({
    view_options = {
        show_hidden = true,
    },
    columns = {
        'icon',
    },
})

-- Oil config
vim.keymap.set('n', '<leader>po', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- telescope config
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})

-- Mason & lsp config
require('mason').setup()
require('mason-lspconfig').setup()
vim.opt.termguicolors = true
vim.cmd('colorscheme bamboo')

vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {})
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {})
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {})
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {})
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {})
vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {})
vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
vim.keymap.set({ 'n', 'x' }, 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {})
vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})

-- Blink config
require('blink.cmp').setup({
    keymap = {
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            'snippet_forward',
            'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
    },
    signature = { enabled = true },
})

-- Rest of the configs

vim.keymap.set({ 'n', 'v' }, '<C-j>', '}')
vim.keymap.set({ 'n', 'v' }, '<C-k>', '{')

vim.keymap.set('i', '(', '()<left>')
vim.keymap.set('i', '[', '[]<left>')
vim.keymap.set('i', '{', '{}<left>')

vim.keymap.set('i', "'", "''<left>")
vim.keymap.set('i', '"', '""<left>')

vim.opt.nu = true
vim.opt.rnu = true

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.cursorline = true
vim.opt.winborder = 'rounded'

vim.diagnostic.config({ virtual_text = true })
vim.opt.listchars = {
    tab = '=>',
    trail = '█'
}
vim.opt.list = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'
vim.opt.ignorecase = true

vim.opt.backspace = 'indent,eol,start'
vim.opt.autochdir = false

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
