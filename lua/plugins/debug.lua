-- lua/plugins/debug.lua
return
{
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },

  keys = {
    { "<leader>d",  group = "Debugger", nowait = true, remap = false },

    { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", mode = "n" },
    { "<leader>dc", function() require("dap").continue()          end, desc = "Continue",          mode = "n" },
    { "<leader>di", function() require("dap").step_into()         end, desc = "Step Into",         mode = "n" },
    { "<leader>do", function() require("dap").step_over()         end, desc = "Step Over",         mode = "n" },
    { "<leader>du", function() require("dap").step_out()          end, desc = "Step Out",          mode = "n" },

    { "<leader>dr", function() require("dap").repl.toggle()       end, desc = "Toggle REPL",       mode = "n" },
    { "<leader>dl", function() require("dap").run_last()          end, desc = "Run Last",          mode = "n" },

    { "<leader>db", function() require("dap").list_breakpoints()  end, desc = "List Breakpoints",  mode = "n" },
    { "<leader>de", function() require("dap").set_exception_breakpoints({ "all" }) end, desc = "Set Exception Breakpoints", mode = "n" },

    { "<leader>dh", function() require("dap.ui.widgets").hover()  end, desc = "Evaluate (Hover)",  mode = "n" },

    { "<leader>dq", function()
        local dap, dapui, vt = require("dap"), require("dapui"), require("nvim-dap-virtual-text")
        pcall(dap.terminate)
        pcall(dapui.close)
        pcall(vt.disable)
      end,
      desc = "Terminate", mode = "n"
    },

    { "<leader>dv", function()
        local ok = require("nvim-dap-virtual-text").toggle()
        if ok then print("DAP virtual text enabled") else print("DAP virtual text disabled") end
      end,
      desc = "DAP: Toggle Virtual Text", mode = "n"
    },
  },

  config = function()
    local dap       = require('dap')
    local dapui     = require('dapui')
    local mason_dap = require('mason-nvim-dap')
    local vt        = require('nvim-dap-virtual-text')

    -- 1) Helper to pick python interpreter (Ubuntu: venv > conda > VIRTUAL_ENV > fallback)
    local function pick_project_python()
      local cwd = vim.fn.getcwd()

      -- common project venvs
      local candidates = {
        cwd .. "/venv/bin/python",
        cwd .. "/.venv/bin/python",
        cwd .. "/env/bin/python",
        cwd .. "/.env/bin/python",
      }
      for _, p in ipairs(candidates) do
        if vim.fn.executable(p) == 1 then
          return p
        end
      end

      -- active conda env
      local conda_prefix = os.getenv("CONDA_PREFIX")
      if conda_prefix and #conda_prefix > 0 then
        local p = conda_prefix .. "/bin/python"
        if vim.fn.executable(p) == 1 then return p end
      end

      -- active virtualenv
      local venv = os.getenv("VIRTUAL_ENV")
      if venv and #venv > 0 then
        local p = venv .. "/bin/python"
        if vim.fn.executable(p) == 1 then return p end
      end

      -- fallback
      return nil
    end

    -- 2) Install & wire adapters
    mason_dap.setup({
      automatic_installation = true,
      ensure_installed = { 'delve', 'python', 'bash', 'codelldb' },
      handlers = {
        function(cfg) mason_dap.default_setup(cfg) end,
      },
    })

    -- 3) UI
    dapui.setup({})
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    dap.listeners.before.event_exited['dapui_config']      = function() dapui.close() end

    -- 4) Virtual text
    vt.setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = true,
      virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
      display_callback = function(variable, _, _, _, opts)
        local val = variable.value:gsub("%s+", " ")
        return (opts.virt_text_pos == 'inline') and (" = " .. val) or (variable.name .. " = " .. val)
      end,
    })
    -- 6) Python setup
    local mason_debugpy = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    local python_for_debugpy = pick_project_python() or mason_debugpy
    require('dap-python').setup(python_for_debugpy)

    local function get_python_path()
      return pick_project_python() or python_for_debugpy
    end

    local function load_project_dap()
      local base = {
        {
          type = "python",
          request = "launch",
          name = "Debug: Current File",
          program = "${file}",
          pythonPath = get_python_path,
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "Debug: Project Entry",
          program = function()
            return vim.fn.input("Entry script: ", vim.fn.getcwd() .. "/", "file")
          end,
          args = function()
            local input = vim.fn.input("Args (space-separated): ")
            if input == "" then return {} end
            return vim.split(input, " ")
          end,
          pythonPath = get_python_path,
          justMyCode = false,
        },
      }
      local dap_file = vim.fn.getcwd() .. "/.dap.lua"
      if vim.fn.filereadable(dap_file) == 1 then
        local project_configs = dofile(dap_file)
        for _, cfg in ipairs(project_configs) do
          table.insert(base, cfg)
        end
      end
      dap.configurations.python = base
    end

    load_project_dap()

    vim.api.nvim_create_autocmd("DirChanged", {
      callback = load_project_dap,
      desc = "Reload DAP python configs on directory change",
    })
end
}
