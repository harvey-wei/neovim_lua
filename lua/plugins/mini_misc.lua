return {
	{
		'echasnovski/mini.misc',
		version = '*',
		config = function()
			require('mini.misc').setup(
			{
				-- make_global = {'setup_auto_root'}
			}
			)
		end,
	},
}
