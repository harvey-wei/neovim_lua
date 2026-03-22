return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<leader>tt", desc = "Toggle terminal" },
			{ "<leader>tt", mode = "t", desc = "Toggle terminal" },
			{ "<leader>tn", desc = "New terminal" },
			{ "<leader>tn", mode = "t", desc = "New terminal" },
			{ "<leader>ts", desc = "Select terminal" },
			{ "<leader>ts", mode = "t", desc = "Select terminal" },
			{ "<leader>ta", desc = "Toggle all terminals" },
			{ "<leader>ta", mode = "t", desc = "Toggle all terminals" },
			{ "<leader>th", desc = "Horizontal terminal" },
			{ "<leader>tv", desc = "Vertical terminal" },
			{ "<leader>tb", desc = "Tab terminal" },
			{ "<leader>tr", desc = "Rename terminal" },
			{ "<leader>tr", mode = "t", desc = "Rename terminal" },
			{ "<leader>tl", desc = "Send line to terminal" },
			{ "<leader>tl", mode = "v", desc = "Send selection to terminal" },
			{ "<leader>tg", desc = "Lazygit" },
			{ "<leader>tk", desc = "Kill all terminals" },
			{ "<leader>tk", mode = "t", desc = "Kill all terminals" },
			{ "<leader>tc", desc = "Kill current terminal" },
			{ "<leader>tc", mode = "t", desc = "Kill current terminal" },
		},
		config = function()
			require("toggleterm").setup({
				direction = "float",
				float_opts = {
					border = "curved",
					width = function()
						return vim.o.columns
					end,
					height = function()
						return math.floor(vim.o.lines * 0.8)
					end,
				},
				close_on_exit = true,
				start_in_insert = true,
				persist_size = true,
				persist_mode = true,
				shade_terminals = true,
				auto_scroll = true,
				winbar = { enabled = false },
				responsiveness = {
					horizontal_breakpoint = 135,
				},
			})

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*",
				callback = function()
					local opts = { buffer = 0, silent = true }
					vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
				end,
			})

			vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle terminal", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>tn", function()
				local all = require("toggleterm.terminal").get_all()
				vim.cmd((#all + 1) .. "ToggleTerm direction=float")
			end, { desc = "New terminal", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>ts", function()
				local terms = require("toggleterm.terminal")
				local all = terms.get_all()
				if #all == 0 then
					vim.notify("No terminals open", vim.log.levels.INFO)
					return
				end
				local current = vim.b.toggle_number
				if current then
					local term = terms.get(current)
					if term then term:close() end
				end
				vim.schedule(function()
					vim.cmd("TermSelect")
				end)
			end, { desc = "Select terminal", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals", silent = true })

			vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal", silent = true })
			vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal", silent = true })
			vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Tab terminal", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>tr", "<cmd>ToggleTermSetName<CR>", { desc = "Rename terminal", silent = true })

			vim.keymap.set("n", "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>", { desc = "Send line to terminal", silent = true })

			vim.keymap.set("v", "<leader>tl", function()
				require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
			end, { desc = "Send selection to terminal", silent = true })

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				hidden = true,
				float_opts = {
					border = "curved",
					width = function() return vim.o.columns end,
					height = function() return math.floor(vim.o.lines * 0.9) end,
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.keymap.set("t", "q", function()
						term:toggle()
					end, { buffer = term.bufnr, noremap = true, silent = true })
				end,
			})
			vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Lazygit", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>tk", function()
				local terms = require("toggleterm.terminal").get_all()
				for _, term in ipairs(terms) do
					term:shutdown()
				end
			end, { desc = "Kill all terminals", silent = true })

			vim.keymap.set({ "n", "t" }, "<leader>tc", function()
				local num = vim.b.toggle_number
				if num then
					local term = require("toggleterm.terminal").get(num)
					if term then term:shutdown() end
				end
			end, { desc = "Kill current terminal", silent = true })

			vim.keymap.set("n", "<c-p><c-l>", ":set scrollback=1 | sleep 100m | set scrollback=10000 | echo ''<CR>",
				{ silent = true })
			vim.keymap.set("t", "<c-p><c-l>", [[<C-\><C-n>:set scrollback=1 | sleep 100m | set scrollback=10000<CR>i<C-l>]],
				{ silent = true })
		end,
	},
}
