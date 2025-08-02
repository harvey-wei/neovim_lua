return
{
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},
	{ "mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "clangd" , "pyright"},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
		  local lspconfig = require("lspconfig")

		  -- Optional: shared on_attach and capabilities

		  local on_attach = function(_, bufnr)
			local map = function(mode, lhs, rhs, desc)
			  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			map("n", "gd", vim.lsp.buf.definition, "Go to definition")
			map("n", "K", vim.lsp.buf.hover, "Hover")
			map("n", "gr", vim.lsp.buf.references, "References")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")


			-- https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts
			vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
			-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
			vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
			-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
			-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })


		  end

		  lspconfig.lua_ls.setup({on_attach = on_attach})
		  -- lspconfig.pylsp.setup({on_attach = on_attach})
		  lspconfig.pyright.setup({on_attach = on_attach})
		  lspconfig.clangd.setup({
			  on_attach= on_attach,
			  cmd = { 'clangd', '--compile-commands-dir=build'},
			  filetypes = { 'c', 'cc','cpp', 'objc', 'objcpp', 'cuda' },
		  })

		end,
	},
	{
	  'saghen/blink.cmp',
	  -- optional: provides snippets for the snippet source
	  dependencies = { 'rafamadriz/friendly-snippets' },

	  -- use a release tag to download pre-built binaries
	  version = '1.*',
	  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	  -- build = 'cargo build --release',
	  -- If you use nix, you can build from source using latest nightly rust with:
	  -- build = 'nix run .#build-plugin',

	  ---@module 'blink.cmp'
	  ---@type blink.cmp.Config
	  opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		-- keymap = { preset = 'default' },

		keymap = {
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			['<C-e>'] = { 'hide', 'fallback' },

			['<Tab>'] = {
			  function(cmp)
				if cmp.snippet_active() then return cmp.accept()
				else return cmp.select_and_accept() end
			  end,
			  'snippet_forward',
			  'fallback'
			},
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },

			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
			['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

			['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
		},


		appearance = {
		  -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		  -- Adjusts spacing to ensure icons are aligned
		  nerd_font_variant = 'mono'
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = false } },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
		  default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" }
	  },
	  opts_extend = { "sources.default" }
	}
}
