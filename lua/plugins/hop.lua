return
{
	{
	  'phaazon/hop.nvim',
	  branch = 'v2', -- optional but strongly recommended
	  config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		-- place this in one of your configuration file(s)
		local hop = require('hop')
		local directions = require('hop.hint').HintDirection
		-- vim.keymap.set('', 'f', function()
		--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		vim.keymap.set('', 'f', function()
		  hop.hint_char1({current_line_only = false })
		vim.keymap.set('', 'F', function()
		  hop.hint_char2({current_line_only = false })
		end, {remap=true})
		-- vim.keymap.set('', 'F', function()
		--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, {remap=true})
		-- vim.keymap.set('', 't', function()
		--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		-- end, {remap=true})
		-- vim.keymap.set('', 'T', function()
		--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		-- end, {remap=true})
	  end
	}
}
