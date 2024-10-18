"Could not put in ftplugin gave E117
au FileType tex call TexNewMathZone("N", "align", 1)

filetype plugin on
au FileType * set omnifunc=syntaxcomplete#Complete

augroup filetype
	au! BufNewFile,BufRead *.frag set filetype=c
	au! BufNewFile,BufRead *.vert set filetype=c
	au! BufRead,BufNewFile *.plt set filetype=gnuplot
	au! BufRead,BufNewFile *.txt set filetype=text
augroup END

