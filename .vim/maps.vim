let mapleader = " "

"Spell thingy
nnoremap <leader>n ]s
nnoremap <leader>b [s
nnoremap <leader>z z=

"Def Jumping
nnoremap <leader>gd <C-]>
nnoremap <leader>gb <C-t>

"Going through buffers
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

"File tree on the left
nnoremap <leader>ft :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

"Fix indentations Trim trailing space :%s/\s\+$//e
nnoremap <leader>= gg<S-v>G=<C-o><C-o>zz 

"Completions using tab
function! CleverTab()
	if pumvisible()
		return "\<C-P>"
	else
		return "\<Tab>"
	endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
inoremap <S-Tab> <C-N>
inoremap <leader><Tab> <C-x><C-f>
nnoremap <Tab> :e<space>

"Up and down
"nnoremap <leader>k <C-u>
"nnoremap <leader>j <C-d>

"Non-leadery
nnoremap <return> o<esc>
nnoremap <UP> <C-u>
nnoremap <LEFT> BB
nnoremap <RIGHT> WW
nnoremap <DOWN> <C-d>

"Insert mode
inoremap jk <esc>
inoremap <leader>. <esc>la
inoremap <leader>, <esc>hi
