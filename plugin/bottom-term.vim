let s:toggleOn = 0
command! runbotterm call RunBottomTerminal()
command! closebotterm call CloseBottomTerminal()
command! shterm call ShowHideTerminal()

nnoremap <F2> :shterm

function! ShowHideTerminal()
	if s:toggleOn
		execute "runbotterm"
	else
		execute "closebotterm"
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
