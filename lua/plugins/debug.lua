-- debug.lua
-- ref: https://github.com/nvim-lua/kickstart.nvim
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

	-- Virtual text to show value of variables
	'theHamsta/nvim-dap-virtual-text',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
	'mfussenegger/nvim-dap-python',
  },
  -- load dap only when the any of the above key is pressed
  keys =
	{
	  -- Debugger
	  {
		  "<leader>x",
		  group = "Debugger",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xt",
		  function()
			  require("dap").toggle_breakpoint()
		  end,
		  desc = "Toggle Breakpoint",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xc",
		  function()
			  require("dap").continue()
		  end,
		  desc = "Continue",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xi",
		  function()
			  require("dap").step_into()
		  end,
		  desc = "Step Into",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xo",
		  function()
			  require("dap").step_over()
		  end,
		  desc = "Step Over",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xu",
		  function()
			  require("dap").step_out()
		  end,
		  desc = "Step Out",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xr",
		  function()
			  require("dap").repl.toggle()
		  end,
		  desc = "Toggle REPL",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xl",
		  function()
			  require("dap").run_last()
		  end,
		  desc = "Run Last",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xq",
		  function()
			  require("dap").terminate()
			  require("dapui").close()
			  require("nvim-dap-virtual-text").toggle()
		  end,
		  desc = "Terminate",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xb",
		  function()
			  require("dap").list_breakpoints()
		  end,
		  desc = "List Breakpoints",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xe",
		  function()
			  require("dap").set_exception_breakpoints({ "all" })
		  end,
		  desc = "Set Exception Breakpoints",
		  nowait = true,
		  remap = false,
	  },
	  {
		  "<leader>xh",
		  function()
			require("dap.ui.widgets").hover()
		  end,
		  desc = "Evaluate Variable (Hover)",
		  -- mode = { "n", "v" }, -- both normal and visual mode
		  nowait = true,
		  remap = false,
	  },
	},
  -- keys = {
  --   -- Basic debugging keymaps, feel free to change to your liking!
  --   {
  --     '<F5>',
	 --  -- '<leader>db',
  --     function()
  --       require('dap').continue()
  --     end,
  --     desc = 'Debug: Start/Continue',
  --   },
  --   {
  --     '<F1>',
  --     function()
  --       require('dap').step_into()
  --     end,
  --     desc = 'Debug: Step Into',
  --   },
  --   {
  --     '<F2>',
  --     function()
  --       require('dap').step_over()
  --     end,
  --     desc = 'Debug: Step Over',
  --   },
  --   {
  --     '<F3>',
  --     function()
  --       require('dap').step_out()
  --     end,
  --     desc = 'Debug: Step Out',
  --   },
  --   {
  --     '<leader>b',
  --     function()
  --       require('dap').toggle_breakpoint()
  --     end,
  --     desc = 'Debug: Toggle Breakpoint',
  --   },
  --   {
  --     '<leader>B',
  --     function()
  --       require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  --     end,
  --     desc = 'Debug: Set Breakpoint',
  --   },
  --   -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  --   {
  --     '<F7>',
  --     function()
  --       require('dapui').toggle()
  --     end,
  --     desc = 'Debug: See last session result.',
  --   },
  -- },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
	local mason_dap = require("mason-nvim-dap")
	local dap_virtual_text = require("nvim-dap-virtual-text")

    mason_dap.setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
		  function (config)
			   require("mason-nvim-dap").default_setup(config)
		  end
	  },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
		'python',
		'bash',
		'codelldb',
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      -- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      -- controls = {
      --   icons = {
      --     pause = '⏸',
      --     play = '▶',
      --     step_into = '⏎',
      --     step_over = '⏭',
      --     step_out = '⏮',
      --     step_back = 'b',
      --     run_last = '▶▶',
      --     terminate = '⏹',
      --     disconnect = '⏏',
      --   },
      -- },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

	dap_virtual_text.setup {
		enabled = true,                        -- enable this plugin (the default)
		enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true,               -- show stop reason when stopped for exceptions
		commented = false,                     -- prefix virtual text with comment string
		only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
		all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
		clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
		--- A callback that determines how a variable is displayed or whether it should be omitted
		--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
		--- @param buf number
		--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
		--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
		--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
		--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
		display_callback = function(variable, buf, stackframe, node, options)
		-- by default, strip out new line characters
		  if options.virt_text_pos == 'inline' then
			return ' = ' .. variable.value:gsub("%s+", " ")
		  else
			return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
		  end
		end,
		-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
		virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

		-- experimental features:
		all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
											   -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	}

	vim.keymap.set("n", "<leader>dv", function()
	  local ok = require("nvim-dap-virtual-text").toggle()
	  if ok then
		print("DAP virtual text enabled")
	  else
		print("DAP virtual text disabled")
	  end
	end, { desc = "DAP: Toggle Virtual Text" })



    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.open
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
	-- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
	-- mason-nvim-dap install a python in the virtual environemnt where debugpy is installed!
	dap.configurations = {
		python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- debugpy as debuger adapter the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
				-- we can use the same launch fine as that in vscode

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.

					-- mason-nvim-dap install the debugpy to the following path
					-- Each python interpreter has its own debugpy.
					local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						-- return "/usr/bin/python"
						return python
					end

					-- mason-nvim-dap install the debugpy to the following path
					-- local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
					-- return python
				end,
				stopOnEntry = false,
			},
		},
	}
	-- require('dap-python').setup(python)

  end,
}
