-- lazy.nvim
return
{
	{
	  "folke/noice.nvim",
	  event = "VeryLazy",
	  dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
		},
		config = function ()
			require("noice").setup({
			  lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
				  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				  ["vim.lsp.util.stylize_markdown"] = true,
				  ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			  },
			  -- you can enable a preset for easier configuration
			  presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = {
					enable = true,
					views = {
						cmdline_popup = {
						  position = { row = "50%", col = "50%" },
						  size = {
							min_width = 60,
							width = "auto",
							height = "auto",
						  },
					},
						-- If you're using popup menus too, center this as well:
						cmdline_popupmenu = {
						  position = { row = "67%", col = "50%" },
						},
					},
				}, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			  },

				-- Block which-key warning messages
			routes = {
			  {
				view = "notify", -- optional, can be "mini", "split", etc.
				filter = {
				  event = "notify",
				  -- kind = "warn", -- string, not vim.log.levels.WARN
				  find = "which-key",
				},
				opts = { skip = true },
			  },
			}
			})
		end
	}
}
