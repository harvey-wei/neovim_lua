local fine_cmd_config = function ()
	require('fine-cmdline').setup({
		  cmdline = {
			enable_keymaps = true,
			smart_history = true,
			prompt = ': '
		  },
		  popup = {
			position = {
			  row = '30%',
			  col = '50%',
			},
			size = {
			  width = '60%',
			},
			border = {
			  style = 'rounded',
			},
			win_options = {
			  winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
			},
		  },
	})
	vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
end

return
{
	{
		'VonHeikemen/fine-cmdline.nvim',
		dependencies ={'MunifTanjim/nui.nvim'},
		config = function ()
			fine_cmd_config()
		end
	}
}
