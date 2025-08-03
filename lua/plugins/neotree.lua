return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
	config = function ()

	-- Toggle Neo-tree
	vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

	-- Reveal current file in Neo-tree
	vim.keymap.set("n", "<leader>re", "<cmd>Neotree reveal<CR>", { desc = "Reveal file in Neo-tree" })

	-- Show Neo-tree on left, filesystem view
	vim.keymap.set("n", "<leader>fe", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Filesystem Explorer" })

	-- Show buffers in Neo-tree
	vim.keymap.set("n", "<leader>fb", "<cmd>Neotree buffers reveal float<CR>", { desc = "Buffer Explorer" })

	-- Show git status in Neo-tree
	vim.keymap.set("n", "<leader>fg", "<cmd>Neotree git_status reveal float<CR>", { desc = "Git Explorer" })

	end
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}
