local M = {}

function M.setup()
    vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})

    -- Select all text in current buffer
    vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
end

return M