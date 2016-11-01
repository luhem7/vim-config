"------------------------------------------------------------------
" => Vim pathogen plugin
"------------------------------------------------------------------
try
    execute pathogen#infect()
catch
    echoerr 'Pathogen plugin not detected or misconfigured'
endtry

"------------------------------------------------------------------
" => Windows git bash xterm mapping 
"------------------------------------------------------------------
" Mapping the <M-> shortcuts in vim to the actual characters 
" sent by xterm in git bash on windows
set <M-j>=j
set <M-k>=k

"------------------------------------------------------------------
" => General
"------------------------------------------------------------------
" Sets how many lines of history VIM has to remember
if &history < 1000
  set history=1000
endif

"Max number of tabs vim can open
if &tabpagemax < 50
  set tabpagemax=50
endif

"Use viminfo file
if !empty(&viminfo)
  set viminfo^=!
endif

"Options for mksession files
set sessionoptions-=options

" Enable filetype plugins
if has('autocmd')
    filetype plugin on
    filetype indent on
endif

" By default vim treats .md files as Modula 2, here always treat
" .md files as if they are markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "


" Fast saving here
nmap <leader>w :w!<cr>

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/bin/bash
endif

set autoread

"------------------------------------------------------------------
" => VIM user interface
"------------------------------------------------------------------
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" No annoying sound on errors
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"Always show line numbers:
set nu

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"make netrw use the tree view by default
let g:netrw_liststyle=3

" Enable folding
set foldmethod=indent
set foldlevel=99

"------------------------------------------------------------------
" => Colors and Fonts
"------------------------------------------------------------------
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h8:cANSI
  endif
endif

" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable 
endif

" Custom color scheme
try
    set background=light
    colorscheme solarized 
catch
    silent! colorscheme desert
endtry

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf8
endif

"------------------------------------------------------------------
" => Files, backups, undo and session management
"------------------------------------------------------------------
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"Shortcut keys to save current session and load session
nnoremap <leader>ss :mksession! ~/vimsession.vim<cr>
nnoremap <leader>sl :so ~/vimsession.vim<cr>

"------------------------------------------------------------------
" => Text, tab and indent related
"------------------------------------------------------------------
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set complete-=i
set nrformats-=octal

" For use with set list when you want to see whitespace characters
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j 
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Python specific, ensure that text width does not exceed 80 chars
au BufNewFile,BufRead *.py set textwidth=79
"------------------------------------------------------------------
" => Visual mode related
"------------------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"------------------------------------------------------------------
" => Moving around, tabs, windows and buffers
"------------------------------------------------------------------
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext navigation commands
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Easy window navigation commands
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"------------------------------------------------------------------
" => Status line
"------------------------------------------------------------------
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"------------------------------------------------------------------
" => Editing mappings
"------------------------------------------------------------------
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"------------------------------------------------------------------
" => Misc
"------------------------------------------------------------------
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"------------------------------------------------------------------
" => Helper functions
"------------------------------------------------------------------
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
      buffer #
    else
      bnext
    endif

    if bufnr("%") == l:currentBufNum
      new
    endif

    if buflisted(l:currentBufNum)
      execute("bdelete! ".l:currentBufNum)
    endif
endfunction

"------------------------------------------------------------------
" => Plugin options
"------------------------------------------------------------------
" vim-fugitive open Gdiff in vertical splits
set diffopt+=vertical

" For the SimpylFold plugin:
" Don't want to see your docstrings folded
let g:SimpylFold_fold_docstring = 0
" Don't want to see your imports folded
let g:SimpylFold_fold_import = 0

"------------------------------------------------------------------
" => Setting custom brackets matching options. No idea why has
" to be at the bottom to actually work. Putting it higher up
" is just ignoring it
"------------------------------------------------------------------

" Show matching brackets when text indicator is over them
set showmatch 
" Bracket matching color options
hi MatchParen cterm=underline ctermbg=none ctermfg=white
