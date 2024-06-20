return {
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
		config = function ()
			require('Comment').setup()
			local ft = require('Comment.ft')
			ft.cpp = {'/*%s*/', '/*%s*/'}
			ft.c = {'/*%s*/', '/*%s*/'}
			ft.cuda = {'/*%s*/', '/*%s*/'}

		end
	}
}
