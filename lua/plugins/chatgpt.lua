return {
	{
	  "jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
		  "MunifTanjim/nui.nvim",
		  "nvim-lua/plenary.nvim",
		  "folke/trouble.nvim",
		  "nvim-telescope/telescope.nvim"
		},
		config = function()
			require("chatgpt").setup({
			api_key_cmd = "gpg --decrypt  " .. vim.fn.expand("$HOME") .. "/.openai_key.txt.gpg"
			})
		end,
	}
}
