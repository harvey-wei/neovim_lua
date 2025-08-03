return
{
	{
		"mfussenegger/nvim-dap",
			dependencies = {
			  "rcarriga/nvim-dap-ui",
			  "theHamsta/nvim-dap-virtual-text",
			  "nvim-neotest/nvim-nio",
			  "mfussenegger/nvim-dap-python"

	},
    config = function()
		local dap = require "dap"
		local ui = require "dapui"
		-- local cmd = os.getenv('HOME') .. '/.config/nvim/data/debug/tools/extension/adapter/codelldb'

		-- load dapui.setup
		require("dapui").setup()
		require('nvim-dap-virtual-text').setup()

		-- c++
		-- codellab is the adapter for c++
		dap.adapters.codelldb = {
		  type = 'server',
		  port = "${port}",
		  executable = {
			command = '/home/harvey/.config/nvim/data/debug/tools/extension/adapter/codelldb',
			args = {"--port", "${port}"},
		  }
		}

		-- Tell dap which adapter to use for c++
		dap.configurations.cpp = {
		  {
			name = "Launch file",
			type = "codelldb", -- the adapter for c++ and it should match dap.adapters.codelldb
			request = "launch",
			program = function()
			  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			runInTerminal = false,
		  },
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		-- Global python or the python in virtual environment
		require('dap-python').setup('python3')

		-- Optional: Set up virtual environment if needed
		-- require('dap-python').setup('path/to/your/python')

		-- Optional: Configure other settings
		-- require('dap-python').test_runner = 'pytest'

		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
		require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F12>", dap.restart)

		-- Tell dap how to run the dapui in the current window
		dap.listeners.before.attach.dapui_config = function()
		ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
		ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
		ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
		ui.close()
		end
    end,
  },
}
