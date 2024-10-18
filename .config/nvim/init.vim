"       _
"__   _(_)_ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__
"  \_/ |_|_| |_| |_|_|  \___|

source ~/.config/nvim/set.vim

syntax on

source ~/.config/nvim/pop.vim

source ~/.config/nvim/file.vim

call plug#begin('~/.config/nvim/plugged')

"Quotes, brackets and parentheses
Plug 'jiangmiao/auto-pairs'

"Latex thingy for vim
"Plug 'latex-box-team/latex-box'

"Auto complete with tabs
Plug 'ervandew/supertab'

"Going to files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"List of buffers and nice line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Snippets (custom)
Plug 'sirver/ultisnips'

call plug#end()

source ~/.config/nvim/maps.vim

"All plugin setup here itself

"Despo FZF use
nnoremap <S-Tab> :FZF ~<CR>

"Airline Stuff
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1

"Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<leader><leader>"
let g:UltiSnipsJumpForwardTrigger="<leader><leader>"
"let g:UltiSnipsJumpBackwardTrigger="<leader>h"
