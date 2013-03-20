" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set background=dark

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*.erl set nu

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" I like to see numlines from the beginning
set nu

" Automatically indent based on file type: 
filetype indent on
" Keep indentation level from previous line:
set autoindent

" Folding based on indentation: ``set foldmethod=indent``

" handle this in snippets
"abbr setBP import ipdb;ipdb.set_trace()
"abbr setBPQ import pdb4qt; pdb4qt.set_trace()
"abbr NI** raise NotImplementedError
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif



iab lenght length
iab max_lenght max_length

set mouse=a

" fuck arrow keys...
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Searching
set incsearch
set hls
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"autocmd FileType python compiler pylint
"let g:pylint_onwrite = 0
"let g:pylint_show_rate = 0
"let g:pylint_cwindow = 0
"let g:pylint_signs = 0


set nocompatible " Disable vi-compatibility
set laststatus=2 " Always show the statusline

set t_Co=256 " Explicitly tell vim that the terminal has 256 colors

"colorscheme simple256
"colorscheme transparent
"colorscheme slate
"colorscheme delek
"colorscheme paintbox

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256 "w/o this, it appears a green color... 
"but ... it's not so bad
colorscheme solarized
let g:Powerline_symbols = 'unicode'

" !!!!
" custom schemes creator: http://www.bilalquadri.com/villustrator/

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins

" let g:pyflakes_use_quickfix = 0
let g:pyflakes_use_quickfix = 0

call togglebg#map("<F5>")

augroup filetypedetect 
au BufNewFile,BufRead access.log*   setf httpclog 
au BufNewFile,BufRead error.log*   setf httpclog 
augroup END


" comment line, selection with Ctrl-N,Ctrl-N
au BufEnter *.py nnoremap  <C-N><C-N>    mn:s/^\(\s*\)#*\(.*\)/\1#\2/ge<CR>:noh<CR>`n
au BufEnter *.py inoremap  <C-N><C-N>    <C-O>mn<C-O>:s/^\(\s*\)#*\(.*\)/\1#\2/ge<CR><C-O>:noh<CR><C-O>`n
au BufEnter *.py vnoremap  <C-N><C-N>    mn:s/^\(\s*\)#*\(.*\)/\1#\2/ge<CR>:noh<CR>gv`n

" uncomment line, selection with Ctrl-N,N
au BufEnter *.py nnoremap  <C-N>n     mn:s/^\(\s*\)#\([^ ]\)/\1\2/ge<CR>:s/^#$//ge<CR>:noh<CR>`n
au BufEnter *.py inoremap  <C-N>n     <C-O>mn<C-O>:s/^\(\s*\)#\([^ ]\)/\1\2/ge<CR><C-O>:s/^#$//ge<CR><C-O>:noh<CR><C-O>`n
au BufEnter *.py vnoremap  <C-N>n     mn:s/^\(\s*\)#\([^ ]\)/\1\2/ge<CR>gv:s/#\n/\r/ge<CR>:noh<CR>gv`n" 

" abbr to insert ts
:iab <expr> dts strftime("%Y-%m-%d %H:%M")
:iab itemdo * [ ]

" tagbar toggle
nmap <F9> :TagbarToggle<CR>

" let g:Powerline_symbols = 'fancy'

" Pymode
" I think this is making vim a little slow lately...
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint_write = 0
let g:pymode_motion = 0

" Vimwiki remap (cause C-Space is taken on my awesome rc)
" marks todo items
nmap <silent><buffer> <C-b> <Plug>VimwikiToggleListItem
vmap <silent><buffer> <C-b> <Plug>VimwikiToggleListItem

" rst binding for rebuilding docs
" (useful for sphinx)
au BufEnter *.rst nnoremap <F2>   :w<CR>:!make html<CR>
au BufEnter *.rst inoremap <F2>   :w<CR>:!make html<CR>
au BufEnter *.rst vnoremap <F2>   :w<CR>:!make html<CR>

" set foldmethod=indent
" set foldlevel=99
