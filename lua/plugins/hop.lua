return
{
	{
	  'smoka7/hop.nvim',
	  version = "*",
	  config = function()
		require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		local hop = require('hop')

		vim.keymap.set('', 'f', function()
		  hop.hint_char1({current_line_only = false })
		end, {remap=true})

		vim.keymap.set('', 'F', function()
		  hop.hint_char2({current_line_only = false })
		end, {remap=true})
	  end
	}
}
