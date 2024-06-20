local floaterm_config = function()
	vim.cmd([[
		let g:floaterm_position = 'center'
		let g:floaterm_width = 1.0
		let g:floaterm_height = 0.8
		let g:floaterm_autoclose = 2
		let g:floaterm_autoinsert = 1
		let g:floaterm_wintype = 'float'
		let g:floaterm_keymap_new = '<Leader>t'
		let g:floaterm_keymap_prev = '<Leader>pt'
		let g:floaterm_keymap_next = '<Leader>nt'
		let g:floaterm_keymap_first = '<Leader>ft'
		let g:floaterm_keymap_last = '<Leader>lt'
		let g:floaterm_keymap_hide = '<Leader>ht'
		let g:floaterm_keymap_show = '<Leader>gt'
		let g:floaterm_keymap_kill = '<Leader>kt'
		" let g:floaterm_keymap_toggle = '<Leader>st'

		nnoremap <Leader>ka :FloatermKill!<CR>
		tnoremap <Leader>f+ <cmd>FloatermUpdate --height=1.0<cr>
		tnoremap <Leader>f- <cmd>FloatermUpdate --height=g:floaterm_height<cr>
		nnoremap <Leader>f+ <cmd>FloatermUpdate --height=1.0<cr>
		nnoremap <Leader>f- <cmd>FloatermUpdate --height=g:floaterm_height<cr>

		" https://vi.stackexchange.com/questions/21260/how-to-clear-neovim-terminal-buffer
		nmap <c-p><c-l> :set scrollback=1 \| sleep 100m \| set scrollback=10000 \| :echo ''<CR>
		tmap <c-p><c-l> <c-\><c-n><c-p><c-l>i<c-l>
	]])
end

return
{
	{
		'voldikss/vim-floaterm', version = "*"
	},

	floaterm_config()
}
