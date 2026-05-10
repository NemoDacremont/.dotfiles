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

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
    { src = gh("nvim-neo-tree/neo-tree.nvim"),              version = "3.40.0" },
    { src = gh("MunifTanjim/nui.nvim"),                     version = "0.4.0" },
    { src = gh("nvim-treesitter/nvim-treesitter"),          version = "4916d6592ede8c07973490d9322f187e07dfefac" },
    { src = gh("nvim-telescope/telescope.nvim"),            version = "v0.2.1" },
    { src = gh("nvim-lua/plenary.nvim"),                    version = "master" },                 -- Telescope & neo-tree dep
    { src = gh("nvim-telescope/telescope-fzf-native.nvim"), version = "main",   build = "make" }, -- Telescope dep
    { src = gh("nvim-tree/nvim-web-devicons"),              version = "v0.100" },                 -- Telescope dep
    { src = gh("neovim/nvim-lspconfig"),                    version = "v2.7.0" },                                                            -- Basic config for LSP
    { src = gh("mason-org/mason.nvim"),                     version = "v2.2.1" },                 -- Download LSP easily
    { src = gh("mason-org/mason-lspconfig.nvim"),           version = "v2.1.0" },                 -- Auto enable LSP from mason
    { src = gh("morhetz/gruvbox") },
    { src = gh("saghen/blink.cmp"),                         version = "v1.10.2" } -- Better auto-complete
})

vim.cmd("colorscheme gruvbox")
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>po", "<Cmd>Neotree toggle<CR>")

vim.keymap.set({ 'n', 'x' }, '<C-j>', '}', {})
vim.keymap.set({ 'n', 'x' }, '<C-k>', '{', {})

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- visual markers
vim.opt.cursorline = true
vim.opt.winborder = "rounded"
vim.opt.colorcolumn = "80"

vim.diagnostic.config({ virtual_text = true })
vim.opt.listchars = {
    tab = '=>',
    trail = '█'
}
vim.opt.list = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8

-- Remove status i don't care about
vim.opt.laststatus = 0  -- status line at the bottom
vim.opt.signcolumn = "no"  -- "yes"  # Show Errors, warning ... on left

-- Search easy
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Enable generating TOC in markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set('n', '<leader>gO', function()
            require('vim.treesitter._headings').show_toc()
            vim.cmd("Neotree close")
            vim.cmd("wincmd H")
            vim.cmd("set nonu")
            vim.cmd("set nornu")
            vim.cmd("set wrap nowrap")
            vim.cmd("vertical resize 40")
            vim.cmd("wincmd p")
        end, { buffer = 0, silent = true, desc = 'Show an Outline of the current buffer' })
    end,
})
