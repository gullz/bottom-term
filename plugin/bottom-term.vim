let s:toggleOn = 0

command! RunBotTerm call RunBottomTerminal()
command! CloseBotTerm call CloseBottomTerminal()
command! SHTerm call ShowHideTerminal()

nnoremap <F2> :SHTerm<CR>

function! ShowHideTerminal()
	if s:toggleOn
		execute "CloseBotTerm"
	else
		execute "RunBotTerm"
	endif
endfunction


function! RunBottomTerminal()
	" Add terminal window, resize it to contain 15lines, swap window with other
	let s:toggleOn = 1
	execute "term"
	execute "resize 15"
	execute "wincmd r"
	execute "wincmd p"
endfunction

function! CloseBottomTerminal()
	let s:toggleOn = 0
	execute "wincmd b"
	execute "wincmd r"
	execute "quit!"
endfunction
