local M = {}

function M.setup()
    vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})

end

return M