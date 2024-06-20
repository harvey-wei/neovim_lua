local M = {}

function M.setup()
    -- Reload our nvim config
    vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
end

return M