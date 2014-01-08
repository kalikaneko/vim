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

" wrapping
set wrap
set linebreak
set nolist  " list disables linebreak

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

let g:pylint_onwrite = 0
"let mapleader = ","
nnoremap <leader>p :PyLint<cr>    " pressing ,p will run plyint on current buffer

set nocompatible " Disable vi-compatibility


set laststatus=2 " Always show the statusline
" set statusline = "%{fugitive#statusline()}"  " add branch to statusline

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

" filetype on            " enables filetype detection
filetype off            " disables filetype detection
                        " required by vundle ^^^
filetype plugin on     " enables filetype specific plugins

" let g:pyflakes_use_quickfix = 0
let g:pyflakes_use_quickfix = 0

call togglebg#map("<F5>")

" move between tabs
nnoremap <C-H> :tabprevious<CR>
inoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>
inoremap <C-L> :tabnext<CR>
nnoremap <C-W>t :tabnew 
inoremap <C-W>t :tabnew 

" paste mode
nnoremap <C-W>p :set paste!<CR>
inoremap <C-W>p :set paste!<CR>

" mail filetype
nnoremap <C-W>m :set filetype=mail<CR>
inoremap <C-W>m :set filetype=mail<CR>

"nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" With the following, you can press F7 to show all buffers in tabs, or to close
" all tabs (toggle: it alternately executes :tab ball and :tabo).
let notabs = 1
nnoremap <silent> <F7> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>


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
iab <expr> dts strftime("%Y-%m-%d %H:%M")
iab itemdo * [ ]

" tagbar toggle
nmap <F9> :TagbarToggle<CR>

" let g:Powerline_symbols = 'fancy'

" Pymode
" I think this is making vim a little slow lately...
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint_write = 0
let g:pymode_motion = 0

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Vimwiki remap (cause C-Space is taken on my awesome rc)
" marks todo items
nmap <leader>tt <Plug>VimwikiToggleListItem
vmap <leader>tt <Plug>VimwikiToggleListItem

" rst binding for rebuilding docs
" (useful for sphinx)
au BufEnter *.rst nnoremap <F2>   :w<CR>:!make html<CR>
au BufEnter *.rst inoremap <F2>   :w<CR>:!make html<CR>
au BufEnter *.rst vnoremap <F2>   :w<CR>:!make html<CR>

" set foldmethod=indent
" set foldlevel=99

if has('autocmd')
  au BufRead,BufNewFile *.txt set wm=2 tw=80
endif

if has('autocmd')
  au BufRead,BufNewFile *.rst set wm=2 tw=80
endif

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set wrap linebreak

""" python/supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

""" tags
""" see http://www.held.org.il/blog/2011/02/configuring-ctags-for-python-and-vim/
set tags=~/mytags

""" jedi bindings
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-p>"

""" leader-r is colliding wth something else
let g:jedi#rename_command = "<leader>t"
let g:jedi#show_call_signatures = "1"
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview



""" notmuch-vim
"""should filter by leap-list tag instead
let g:notmuch_folders = [
	\ [ 'pers', 'tag:pers' ],
	\ [ 'friends', 'tag:friends' ],
	\ [ 'new', 'tag:inbox and tag:unread' ],
	\ [ 'bare-inbox', 'tag:inbox and not tag:lists' ],
	\ [ 'inbox', 'tag:inbox' ],
	\ [ 'leap', 'subject:"leap"' ], 
	\ [ 'leap-chili', 'from:chili' ],
	\ [ 'cryptography', 'tag:lists and tag:cryptography' ],
	\ [ 'nettime', 'tag:lists and tag:nettime-l' ],
	\ [ 'tor-dev', 'tag:lists and tag:tor-dev' ],
	\ [ 'python-dev', 'tag:lists and tag:python-dev' ],
	\ [ 'debian-devel', 'tag:lists and tag:debian-devel' ],
	\ [ 'leap-git', 'from:leap-code-o-matic or from:gitolite@hare' ],
	\ ]


" vundles!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 " let Vundle manage Vundle
 " required! 
Bundle 'gmarik/vundle'

 " My Bundles here: 

" git repos

" XXX uh --- I had a vbroken/old vim-powerline,
" but it *was* working it it.
Bundle 'Lokaltog/powerline'

Bundle 'flazz/vim-colorschemes'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'motemen/git-vim'
Bundle 'mustache/vim-mode'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'jbking/vim-pep8'
Bundle 'fs111/pydoc.vim'
Bundle 'kevinw/pyflakes-vim'
Bundle 'vim-scripts/vimwiki'
Bundle 'vim-scripts/grep.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'FredKSchott/CoVim'
Bundle 'ervandew/supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'davidhalter/jedi-vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'vim-scripts/SyntaxRange'
Bundle 'sjl/gundo.vim'
Bundle 'bridgeutopia/vim-showmarks'
Bundle 'rosenfeld/conque-term'
Bundle 'szw/vim-dict'


filetype plugin indent on     " required!


" Map F3 to Grep
nnoremap <silent> <F3> :Grep<CR>
" Map Leader-T to ConqueTerm
nnoremap <silent> <leader>TT :ConqueTermVSplit zsh<CR>

" Vim-Dict configuration
let g:dict_hosts = [
    \["dict.org", ["gcide", "wn", "moby-thes", "vera", "jargon", "foldoc", "bouvier", "devil"]]
    \]

" do not start showmarks (use \mt to toggle)
let g:showmarks_enable = 0

" edit vimrc!
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

