-- Ref: https://m4xshen.dev/posts/build-your-modern-neovim-config-in-lua/

--  Make Mason-installed language servers like pylsp discoverable by Neovim via just like cmd={"pylsp"}
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath("data") .. '/mason/bin'

require('config.settings').setup()
require('config.keybindings').setup()
require('config.utils').setup()
require('config.lazy')
require('lsp.lsp_set').setup()



-- Give msg if attached to LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP attached:", client.name)
  end,
})
