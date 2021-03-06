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

" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()

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
set statusline = "%{fugitive#statusline()}"  " add branch to statusline

set t_Co=256 " Explicitly tell vim that the terminal has 256 colors

"colorscheme simple256
"colorscheme transparent
"colorscheme slate
"colorscheme delek
"colorscheme paintbox


" filetype on            " enables filetype detection
filetype off            " disables filetype detection
                        " required by vundle ^^^
filetype plugin on     " enables filetype specific plugins

" let g:pyflakes_use_quickfix = 0
let g:pyflakes_use_quickfix = 0

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

" SQUASH -- for rebase !
map ,s dwis <ESC>
map ,c :VimuxPromptCommand<CR>
map ,e :g/^$/d<CR>


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
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

""" tags
""" see http://www.held.org.il/blog/2011/02/configuring-ctags-for-python-and-vim/
set tags=~/mytags

""" jedi bindings
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = "<leader>d"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-p>"

""" leader-r is colliding wth something else
"let g:jedi#rename_command = "<leader>t"
"let g:jedi#show_call_signatures = "1"
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#popup_on_dot = 0

""" YCM: do not autotrigger
let &omnifunc = &completefunc 
let g:ycm_auto_trigger = 0
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_cache_omnifunc = 0
let g:ycm_key_invoke_completion = '<C-Y>'
"let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:UltiSnipsExpandTrigger="<C-f>"

"autocmd FileType python setlocal completeopt-=preview



""" notmuch-vim
"""should filter by leap-list tag instead
let g:notmuch_folders = [
	\ [ 'ben@futeisha', 'to:ben@futeisha.org' ],
	\ [ 'kali@futeisha', 'to:kali@futeisha.org' ],
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
	\ [ 'leap-git-UNREAD', 'tag:unread and (from:leap-code-o-matic or from:gitolite@hare)'],
	\ [ 'leap-git', 'from:leap-code-o-matic or from:gitolite@hare' ],
	\ ]


" vundles!
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

 " let Vundle manage Vundle
 " required! 
" Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'

 " My Bundles here: 

" git repos

" looking good
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

" essentials


Plugin 'bling/vim-airline'
Plugin 'vim-scripts/vimwiki'
Plugin 'mhinz/vim-startify'

Plugin 'valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'

" snipmate seems not to be working... switch to UltiSnips...
" I got a fork of snipmate because some problem with... supertab?
Plugin 'garbas/vim-snipmate'
Plugin 'majutsushi/tagbar'
Plugin 'sjl/gundo.vim'

" random stuff
Plugin 'bridgeutopia/vim-showmarks'
Plugin 'vim-scripts/grep.vim'
Plugin 'tpope/vim-surround'
Plugin 'rking/ag.vim' 
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'james9909/stackanswers.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neoyank.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'osyo-manga/unite-airline_themes'


" task handling
Plugin 'farseer90718/vim-taskwarrior'

" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'motemen/git-vim'
Plugin 'kalikaneko/vim-github-links'

" pullreqs
Plugin 'junkblocker/patchreview-vim'
Plugin 'codegram/vim-codereview'

" python
"Plugin 'klen/python-mode'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'kevinw/pyflakes-vim'
"Plugin 'jbking/vim-pep8'
Plugin 'fs111/pydoc.vim'

" syntax
Plugin 'jelera/vim-javascript-syntax'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'mustache/vim-mode'
Plugin 'Shirk/vim-gas'

" Shells and stuff
Plugin 'tomtom/tlib_vim'
Plugin 'rosenfeld/conque-term'
Plugin 'benmills/vimux'
" Some shit with the vimuxpython utils is broken

" Lispy stuff
" Plugin 'jpalardy/vim-slime'
Plugin 'kovisoft/slimv'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'wlangstroth/vim-racket'

" dictionaries
Plugin 'szw/vim-dict'

" window resizing
Plugin 'roman/golden-ratio'
" this need to replace the function definitions to 
" overwrite them (add ! after the function keyword)
Plugin 'vim-scripts/toggle_maximize.vim'
Plugin 'kalikaneko/git-rebase-helper'

" broken stuff
" Plugin 'FredKSchott/CoVim'

call vundle#end()            " required
filetype plugin indent on    " required

set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256 "w/o this, it appears a green color... 
"but ... it's not so bad
colorscheme solarized

" Airline customizations
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'

" Unite
let g:unite_prompt = '»'
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
              \ 'start_insert': 1
              \ }) 

nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>

let g:unite_source_grep_max_candidates = 200

if executable('hw')
  " Use hw (highway)
  " https://github.com/tkengo/highway
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
  " Use ag (the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " Use pt (the platinum searcher)
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  " Use ack
  " http://beyondgrep.com/
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
  \ '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''
endif




" !!!!
" custom schemes creator: http://www.bilalquadri.com/villustrator/
" Map F2 TO SCHEME CHANGER

let g:NumberToggleTrigger="<F2>"


" Map F5 to Toggle Background
call togglebg#map("<F5>")

" Map F3 to Grep
nnoremap <silent> <F3> :Grep<CR>
nnoremap <silent> <F4> :echo GithubLink()<cr>

" Map Leader-T to ConqueTerm
nnoremap <silent> <leader>TT :ConqueTermVSplit zsh<CR>


" Vim-Dict configuration
    "\["dict.org", ["gcide", "wn", "moby-thes", "vera",
    "\              "jargon", "foldoc", "bouvier", "devil"]],
let g:dict_hosts = [
    \["127.0.0.1", ["jargon", "devil", "vera", "moby-thesaurus",
    \"fd-eng-spa"]],
    \]

" do not start showmarks (use \mt to toggle)
let g:showmarks_enable = 0

" edit vimrc!
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

setlocal cursorline

vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
map <Insert> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJ:set nopaste<CR>


"leapder-j/k inserts. nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><leader>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader>k :set paste<CR>m`O<Esc>``:set nopaste<CR>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

let g:syntastic_python_checkers = ['flake8', 'twistedchecker']
set clipboard=unnamedplus
