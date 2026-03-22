local gruvbox_config = function()
	vim.opt.background = "dark"
    vim.opt.termguicolors = true
    vim.cmd.colorscheme('gruvbox')

    -- Make terminal background match the editor background
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
    vim.api.nvim_set_hl(0, "SnacksTerminal", { bg = "#282828" })
    vim.api.nvim_set_hl(0, "SnacksTerminalNormal", { bg = "#282828" })
end

return
{
    {
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = gruvbox_config,
    },
}
