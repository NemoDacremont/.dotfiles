local telescope_setup = false

vim.api.nvim_create_autocmd('UIEnter', {
    callback = function(_)
        if telescope_setup then
            telescope_setup = true
            return
        end

        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>pg', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
    end
})
