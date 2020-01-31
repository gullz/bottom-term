function! RunBottomTerminal()
	" Add terminal window, resize it to contain 15lines, swap window with other
	execute "term"
	execute "resize 15"
	execute "wincmd r"
	execute "wincmd p"
endfunction

