let s:toggleOn = 0
command! RunBottomTerm call RunBottomTerminal()
command! CloseBottomTerm call CloseBottomTerminal()
command! ToggleBottomTerm call ShowHideTerminal()

nnoremap <F2> :ToggleBottomTerm<CR>

function! ShowHideTerminal()
	" Sync state with actual terminal visibility
	let l:term_bufnr = s:FindTerminalBuffer()
	let l:term_visible = (l:term_bufnr != -1 && bufwinnr(l:term_bufnr) != -1)

	if l:term_visible
		call CloseBottomTerminal()
	else
		call RunBottomTerminal()
	endif
endfunction


function! RunBottomTerminal()
	" Check if terminal already exists
	let l:term_bufnr = s:FindTerminalBuffer()

	if l:term_bufnr != -1
		" Terminal buffer exists, check if visible
		if bufwinnr(l:term_bufnr) != -1
			" Terminal already visible, nothing to do
			let s:toggleOn = 1
			return
		else
			" Terminal exists but hidden, reopen it
			let l:curr_winnr = winnr()
			try
				execute "botright sbuffer " . l:term_bufnr
				execute "resize 15"
				execute l:curr_winnr . 'wincmd w'
				let s:toggleOn = 1
			catch
				echohl ErrorMsg
				echo "Failed to open terminal: " . v:exception
				echohl None
				let s:toggleOn = 0
			endtry
			return
		endif
	endif

	" No terminal exists, create a new one
	let l:curr_winnr = winnr()

	" Add terminal window, resize it to contain 15 lines
	try
		execute "botright term"
		execute "resize 15"
		" Return to previous window
		execute l:curr_winnr . 'wincmd w'
		let s:toggleOn = 1
	catch
		echohl ErrorMsg
		echo "Failed to create terminal: " . v:exception
		echohl None
		let s:toggleOn = 0
	endtry
endfunction

function! CloseBottomTerminal()
	" Check if terminal window exists
	let l:term_bufnr = s:FindTerminalBuffer()
	if l:term_bufnr == -1
		let s:toggleOn = 0
		return
	endif

	" Find and close the terminal window
	let l:term_winnr = bufwinnr(l:term_bufnr)
	if l:term_winnr != -1
		execute l:term_winnr . 'wincmd w'
		if &buftype ==# 'terminal'
			close!
		endif
	endif

	let s:toggleOn = 0
endfunction

function! s:FindTerminalBuffer()
	" Find the first terminal buffer
	for bufnr in range(1, bufnr('$'))
		if bufexists(bufnr) && getbufvar(bufnr, '&buftype') ==# 'terminal'
			return bufnr
		endif
	endfor
	return -1
endfunction

" Auto-open terminal on Vim startup if configured
if get(g:, 'bottom_term_auto_open', 0)
	augroup BottomTermAutoOpen
		autocmd!
		autocmd VimEnter * call RunBottomTerminal()
	augroup END
endif

" Auto-close terminal on Vim exit to prevent blocking :qa
augroup BottomTermAutoClose
	autocmd!
	autocmd QuitPre * call s:CloseTerminalOnExit()
augroup END

function! s:CloseTerminalOnExit()
	" Find terminal buffer and force close it
	let l:term_bufnr = s:FindTerminalBuffer()
	if l:term_bufnr != -1
		" Use bwipeout! to force close without confirmation
		execute 'silent! bwipeout! ' . l:term_bufnr
	endif
endfunction
