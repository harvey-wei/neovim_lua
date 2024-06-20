local M = {}
function  M.setup()
    vim.opt.relativenumber = false
	vim.opt.number = true
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.expandtab = true
    vim.opt.smartindent = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.hlsearch = true
	vim.opt.cursorline = true
	-- vim.opt.mouse = a
    vim.g.mapleader = ','
	-- vim.opt.showtabline = 2

    -- disable auto-comment in line continuation
    vim.cmd([[au bufenter * set fo-=c fo-=r fo-=o]])

	-- limit the text width
	vim.cmd([[
		autocmd VimEnter * set textwidth=100 formatoptions+=t
		set cinkeys-=:
		set colorcolumn=100
	]])

	vim.cmd([[ set shell=zsh]])

	vim.cmd('set ruler')
	vim.cmd('syntax on')
	vim.cmd('set encoding=UTF-8')
	vim.cmd('set signcolumn=yes')

	vim.cmd([[
		" -- keep cursorline centered in normal mode -- "
		augroup KeepCentered
		  autocmd!
		  autocmd CursorMoved * normal! zz
		  autocmd CursorMoved * :set cul
		augroup END

" https://stackoverflow.com/questions/3847796/change-working-directory-to-currently-opened-file
		" autocmd BufEnter * lcd %:p:h
		" set cursorline
	]])

end

return M
