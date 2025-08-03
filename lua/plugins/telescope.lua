return
{
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
	  config = function()
			require('telescope').setup{}
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


			vim.keymap.set("n", "<leader>dd", function()
			  require("telescope.builtin").diagnostics({ bufnr = 0 }) -- buffer only
			end, { desc = "Telescope: Buffer Diagnostics" })

			vim.keymap.set("n", "<leader>dD", function()
			  require("telescope.builtin").diagnostics() -- workspace
			end, { desc = "Telescope: Workspace Diagnostics" })

	  end
    },
}
