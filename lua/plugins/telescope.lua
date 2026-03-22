return
{
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
	  config = function()
			require('telescope').setup{}
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })

			-- Jump by tags in the current file
			vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search tags in current file" })

			vim.keymap.set("n", "<leader>dd", function()
			  require("telescope.builtin").diagnostics({ bufnr = 0 }) -- buffer only
			end, { desc = "Telescope: Buffer Diagnostics" })

			vim.keymap.set("n", "<leader>dD", function()
			  require("telescope.builtin").diagnostics() -- workspace
			end, { desc = "Telescope: Workspace Diagnostics" })

	  end
    },
}
