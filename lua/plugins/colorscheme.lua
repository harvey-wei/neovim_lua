local gruvbox_config = function()
	-- gruvbox color theme
	vim.opt.background = "dark"
    vim.opt.termguicolors = true
    vim.cmd.colorscheme('gruvbox')
end

return
{
    {
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = gruvbox_config,
    },
}
