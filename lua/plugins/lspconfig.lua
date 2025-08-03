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
				-- "debugpy"
				-- "shfmt"
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		-- This ensures LSP setup runs before a buffer is fully read.
		event = {"BufReadPre", "BufNewFile"},

		config = function()
			local lspconfig = require("lspconfig")

			-- Optional: shared on_attach and capabilities
			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

			-- local wk = require("which-key")
			-- local opts = { buffer = bufnr, silent = true }

			-- === WHICH-KEY GROUPS (buffer-local) ===
			-- ✅ NEW (recommended)
			-- require("which-key").register({
			--   { "<leader>d", group = "Diagnostics", buffer = bufnr },
			--   { "g", group = "LSP", buffer = bufnr },
			-- })

-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- - "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
-- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

				  -- === LSP keymaps ===
				map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
				map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")
				map("n", "gr", vim.lsp.buf.references, "Go to References")
				map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
				map("n", "grn", vim.lsp.buf.rename, "Rename")
				map("n", "gra", vim.lsp.buf.code_action, "Code Action")
				map("n", "K", vim.lsp.buf.hover, "Hover")

				  -- === Diagnostics keymaps ===


				-- Diagnostics keymaps using vim.keymap.set
				vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, {
				  desc = "Open Diagnostic Float",
				  silent = true,
				})

				vim.keymap.set("n", "<leader>d[", vim.diagnostic.goto_prev, {
				  desc = "Go to Previous Diagnostic",
				  silent = true,
				})

				vim.keymap.set("n", "<leader>d]", vim.diagnostic.goto_next, {
				  desc = "Go to Next Diagnostic",
				  silent = true,
				})

				-- Telescope integration (requires Telescope + Plenary + optional Devicons)
				vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", {
				  desc = "Telescope Diagnostics",
				  silent = true,
				})


				-- https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts
				-- vim.api.nvim_set_keymap('n', '<leader>xo', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
				-- vim.api.nvim_set_keymap('n', '<leader>x[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
				-- vim.api.nvim_set_keymap('n', '<leader>x]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

				-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
				-- vim.api.nvim_set_keymap('n', '<leader>xd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
				-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:

			end

			lspconfig.lua_ls.setup({on_attach = on_attach})
			-- lspconfig.lua_ls.setup({})
			lspconfig.pylsp.setup({
				on_attach = on_attach,
				-- root_dir = function(fname)
				-- 	return vim.fn.getcwd()  -- fallback to current directory
				-- end,
				-- cmd = {'/Users/harvey/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/pylsp'},
			})


			lspconfig.clangd.setup({
			  on_attach = on_attach,
			})

			lspconfig.clangd.filetypes = { "c", "cc", "cpp", "objc", "objcpp", "cuda" }

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

			-- ['<Tab>'] or ['<C-y>']
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
