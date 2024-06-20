return
{
	{
		'neoclide/jsonc.vim',
		config = function ()
		-- Make vim treat all json files as jsonc to allow comments
		-- ref: https://www.codegrepper.com/code-examples/html/coc+allow+comments+in+json
		vim.cmd([[
			augroup JsonToJsonc
				autocmd! FileType json set filetype=jsonc autoread
			augroup END
		]])
		end
	}
}
