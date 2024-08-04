-- local config = function ()
--       require("ibl").setup()
-- 	  vim.g.indent_blankline_use_treesitter = false
-- 	  -- vim.g.indentline_char_list = {'|', '¦', '┆', '┊'}
-- 	  -- vim.g.indent_blankline_char = '¦'
-- 	-- require("ibl").setup()
-- 	-- Embed  vimscript
-- 	-- vim.cmd([[
-- 		-- " let g:indent_blankline_char = '│'
-- 		-- " let g:indent_blankline_filetype_exclude = ['help', 'dashboard', 'dash']
-- 		-- " let g:indent_blankline_buftype_exclude = ['terminal']
-- 		-- " let g:indent_blankline_show_trailing_blankline_indent = false
-- 		-- " let g:indent_blankline_show_first_indent_level = false
-- 		-- " let g:indent_blankline_use_treesitter = true
-- 		-- " let g:indent_blankline_show_current_context = true
-- 		-- " let g:indent_blankline_context_patterns = [
-- 		-- " 	\ 'class', 'function', 'method', 'block', 'list_literal', 'selector', '^if', '^table', 'if_statement', 'while', 'for'
-- 		-- " \]
-- 		-- "
-- 		-- " let g:indentline_enabled = 1
-- 		-- " let g:indentline_setconceal = 0
-- 		-- " let g:indentline_char_list = ['|', '¦', '┆', '┊']
--
-- 	-- ]])
--
-- end

return
{
	-- Give setup
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",
	config = function ()
		-- config()
	  require("ibl").setup({
		  indent = {char = {'|', '¦', '┆', '┊'}},
		  whitespace = {remove_blankline_trail = true},
	  })
	end
	},

 -- { 'lukas-reineke/indent-blankline.nvim',  tag = 'v2.20.8',
 --    config = function()
 --      require("indent_blankline").setup({
 --        show_current_context = false,
 --        show_current_context_start = false,
 --        show_trailing_blankline_indent = true,
 --        use_treesitter = false,
	-- 	-- char = {"|", "¦", "┆", "┊"}
 --      })
 --    end,
 --  },

}
