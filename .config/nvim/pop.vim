"Pop menu behaviour
set tags=./tags,tags;/
set complete+=t
set cot=menuone,noselect

highlight PMenu ctermbg=132
highlight PMenuSel ctermbg=238
highlight PmenuSbar	ctermbg=cyan

"Auto pop omni when in trouble
function! OpenCompletion()
	let l:DefPop = get(b:, "DefPop", "\<C-p>")
	if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
		call feedkeys(l:DefPop, "n")
	endif
endfunction
"autocmd InsertCharPre * call OpenCompletion()
