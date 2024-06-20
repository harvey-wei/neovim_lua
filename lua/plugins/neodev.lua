local neodev_config = function ()
	-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	require("neodev").setup({
	  -- add any options here, or leave empty to use the default settings
	})

	-- then setup your lsp server as usual
	local lspconfig = require('lspconfig')

	-- example to setup lua_ls and enable call snippets
	lspconfig.lua_ls.setup({
	  settings = {
		Lua = {
		  completion = {
			callSnippet = "Replace"
		  }
		}
	  }
	})
end

return
{
	{ "folke/neodev.nvim",
		dependencies = {'neovim/nvim-lspconfig'},
		config = function ()
			neodev_config()
		end
    }
}
