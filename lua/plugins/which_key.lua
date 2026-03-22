return
{
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {},
	  keys = {
		{
		  "<leader>?",
		  function()
			require("which-key").show({ global = false })
		  end,
		  desc = "Buffer Local Keymaps (which-key)",
		},
		{
			"<leader>"
		}
	  },
	  config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>t", group = "Terminal" },
			{ "<leader>t", group = "Terminal", mode = "t" },
			{ "<leader>f", group = "Telescope" },
			{ "<leader>h", group = "Git Hunk" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>a", group = "AI/Claude Code" },

			{ "<C-w>", group = "Window", mode = { "n", "t" } },
			{ "<C-w>h", "<C-\\><C-n><C-w>h", desc = "Move to left window", mode = "t" },
			{ "<C-w>l", "<C-\\><C-n><C-w>l", desc = "Move to right window", mode = "t" },
			{ "<C-w>j", "<C-\\><C-n><C-w>j", desc = "Move to lower window", mode = "t" },
			{ "<C-w>k", "<C-\\><C-n><C-w>k", desc = "Move to upper window", mode = "t" },
			{ "<C-w>w", "<C-\\><C-n><C-w>w", desc = "Cycle to next window", mode = "t" },
			{ "<C-w>p", "<C-\\><C-n><C-w>p", desc = "Previous window", mode = "t" },
		})
	  end,
	}
}
