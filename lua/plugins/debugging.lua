local dap_config = function ()
	-- start codelldb automatically
	-- local dap, dapui = require("dap"), require("dapui")
	local dap = require("dap")
	local dapui = require("dapui")

	require("nvim-dap-virtual-text").setup()

	-- https://github.com/rcarriga/nvim-dap-ui/issues/279
	-- You need to call setup to load dapui
	dapui.setup()

	-- open and close the windows automatically
	dap.listeners.before.attach.dapui_config = function()
	  dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
	  dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
	  dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
	  dapui.close()
	end

	-- dap.toggle_breakpoint instead of dop.toggle_breakpoint()
	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {noremap=true})
	-- vim.keymap.set('n', '<Leader>b', dap.set_breakpoint, {noremap=true})
	vim.keymap.set("n", "<leader>dc", dap.continue, {noremap=true})
	vim.keymap.set("n", "<leader>ds", dap.step_over, {noremap=true})
	vim.keymap.set("n", "<leader>di", dap.step_into, {noremap=true})
	vim.keymap.set("n", "<leader>do", dap.step_out, {noremap=true})
	-- vim.keymap.set('n', '<Leader>dr', dap.repl.open, {noremap=true})
  --   vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
  --   vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
  --   vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
  --   vim.keymap.set('n', '<Leader>df', function()
		-- local widgets = require('dap.ui.widgets')
		-- widgets.centered_float(widgets.frames)
  --   	end
		-- )
		--
  --   vim.keymap.set('n', '<Leader>ds', function()
		-- local widgets = require('dap.ui.widgets')
		-- widgets.centered_float(widgets.scopes)
  --   	end
		-- )
	-- vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
	-- vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open(reset = true)<CR>",
	-- {noremap=true})
	dap.adapters.codelldb = {
	  type = 'server',
	  port = "${port}",
	  executable = {
		-- CHANGE THIS to your path!
		command = '/home/harvey/codelldb/extension/adapter/codelldb',
		args = {"--port", "${port}"},

		-- On windows you may have to uncomment this:
		detached = false,
	  }
	}

	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
			  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}

	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

	-- python debugger
	dap.adapters.python = function(cb, config)
	  if config.request == 'attach' then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or '127.0.0.1'
		cb({
		  type = 'server',
		  port = assert(port, '`connect.port` is required for a python `attach` configuration'),
		  host = host,
		  options = {
			source_filetype = 'python',
		  },
		})
	  else
		cb({
		  type = 'executable',
		  command = '/home/harvey/.virtualenvs/debugpy/bin/python',
		  args = { '-m', 'debugpy.adapter' },
		  options = {
			source_filetype = 'python',
		  },
		})
	  end
	end

	dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch';
		name = "Launch file";

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}"; -- This configuration will launch the current file if used.
		pythonPath = function()
		  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
		  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
		  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
		  local cwd = vim.fn.getcwd()
		  if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
			return cwd .. '/venv/bin/python'
		  elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
			return cwd .. '/.venv/bin/python'
		  else
			  -- Be sure to set the corrent path to python in local machine.
			return '/usr/bin/python3'
		  end
		end;
	  },
	}


end

return
{
	{
		'mfussenegger/nvim-dap',
		dependencies = {'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text'},
		config = function()
			dap_config()
		end
	},
}
