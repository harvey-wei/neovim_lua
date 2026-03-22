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
			ensure_installed = {
				"lua_ls",
				"clangd",
				"pylsp",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = {"BufReadPre", "BufNewFile"},

		config = function()
			-- Configure servers using the native Neovim 0.11+ API
			vim.lsp.config('lua_ls', {})

			vim.lsp.config('pylsp', {})

			vim.lsp.config('clangd', {
				filetypes = { "c", "cc", "cpp", "objc", "objcpp", "cuda" },
			})

			vim.lsp.enable({ 'lua_ls', 'pylsp', 'clangd' })

			-- LSP keymaps via LspAttach autocmd
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
					map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
					map("n", "gr", vim.lsp.buf.references, "Go to References")
					map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
					map("n", "grn", vim.lsp.buf.rename, "Rename")
					map("n", "gra", vim.lsp.buf.code_action, "Code Action")
					map("n", "K", vim.lsp.buf.hover, "Hover")

					map("n", "[o", vim.diagnostic.open_float, "Open Diagnostic Float")
					map("n", "[g", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
					map("n", "]g", vim.diagnostic.goto_next, "Go to Next Diagnostic")
					map("n", "<leader>[", "<cmd>Telescope diagnostics<CR>", "Telescope Diagnostics")
				end,
			})
		end,
	},
	{
	  'saghen/blink.cmp',
	  dependencies = { 'rafamadriz/friendly-snippets' },

	  version = '1.*',

	  ---@module 'blink.cmp'
	  ---@type blink.cmp.Config
	  opts = {
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
		  nerd_font_variant = 'mono'
		},

		completion = { documentation = { auto_show = false } },

		sources = {
		  default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	  },
	  opts_extend = { "sources.default" }
	}
}
