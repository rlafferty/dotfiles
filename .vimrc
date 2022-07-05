set nocompatible              " be iMproved, required
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set showcmd
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set ttyscroll=3                 " Speedup scrolling
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set cmdheight=1
set encoding=utf-8
set mouse=a
set noswapfile
set noshowmode
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set pumheight=10                " Completion window max size
set history=50
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set ruler
set splitbelow                  " Split windows below current, not above

" hybrid line number mode
"set relativenumber
set number
set numberwidth=1

" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

" Convert tabs to spaces
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" Typos are hard
set spell spelllang=en_us

" Enable highlighting for syntax
syntax on

" Make moving to beginning of the line match indentation
nnoremap 0 ^

" Language specific indenting configuration
"autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType sh setlocal expandtab shiftwidth=2 tabstop=2
" Strip trailing whitespace on ruby save
autocmd FileType ruby,go,yaml,json,vim autocmd BufWritePre <buffer> %s/\s\+$//e

autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 expandtab
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
autocmd BufNewFile,BufRead *.gohtml UltiSnipsAddFiletypes html
autocmd BufNewFile,BufRead *.template set syntax=json
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Pep8 formatting
au BufNewFile,BufRead *.py
 \ set tabstop=4 |
 \ set softtabstop=4 |
 \ set shiftwidth=4 |
 \ set textwidth=79 |
 \ set expandtab |
 \ set autoindent |
 \ set fileformat=unix

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

let g:ctrlp_tjump_shortener = ['/home/.*/gems/', '.../']

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Shortcuts for Plugins
nmap <leader>bi :PlugInstall<cr>

" Disable suspend in normal mode
nnoremap <c-z> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM Install
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      !./install.py
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" Sensible Vim plugin
Plug 'tpope/vim-sensible'

" if you use Vundle, load plugins:
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'

" Neocomplete because YCM is a dawg
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'ycm-core/YouCompleteMe'

"Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" clipboard support
Plug 'christoomey/vim-system-copy'

" tpope vim plugins
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

" Indentation guidelines
Plug 'Yggdroot/indentLine'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" language syntax and style plugins
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }
Plug 'jiangmiao/auto-pairs'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'jgdavey/tslime.vim'
"Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
"Plug 'vim-syntastic/syntastic', { 'for': 'python' }
"lug 'nvie/vim-flake8', { 'for': 'python' }

" Linting
Plug 'w0rp/ale'

" Split and Join lines
Plug 'AndrewRadev/splitjoin.vim'

" ctrlp fuzzy finder
Plug 'kien/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" DASH integration
Plug 'rizzatti/dash.vim'

" Vim Themes
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }

" Airline plugins and themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Pretty icons for filetypes
Plug 'ryanoasis/vim-devicons'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM and ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"let g:SuperTabClosePreviewOnPopupClose = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_disable_signature_help = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-ALE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up function to be used by airline
" Function: display errors from Ale in statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Lint only on save
let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
let g:airline_exclude_preview = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-FUGITIVE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts for vim-fugitive
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gst :Gstatus<cr>
nnoremap <leader>gdiff :Gdiff<cr>
nnoremap <leader>glog :Glog<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-GO CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts for vim-go
" always use the quickfix preview window style
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>

" run :GoRun on a go file
autocmd FileType go nmap <leader>gr  <Plug>(go-run)

" run :GoTest on a go file
autocmd FileType go nmap <leader>gt  <Plug>(go-test)

" toggle :GoCoverageToggle to show test coverage
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)

function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

nnoremap <silent> coq :call QuickFix_toggle()<cr>

map <C-n> :lnext<CR>
map <C-m> :lprevious<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP CONFIGURUATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_match_window = 'bottom,order:ttb'          " order matching files from top to bottom
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'  " user silver searcher for wicked speed
let g:ctrlp_max_height = 20
let g:ctrlp_mruf_relative = 1
let g:ctrlp_working_path_mode = 'w'
command! CtrlPLine call ctrlp#init(ctrlp#line#id())
let g:ctrlp_dont_split = 'nerdtree'                    " Make ctrlp's location sync with nerdtree window
let g:ctrlp_working_path_mode = 'ra'                   " Set ctrlp's working path
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>', '<c-i>']
  \ }
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

nnoremap <leader>] :CtrlPtjump<cr>
vnoremap <leader>] :CtrlPtjumpVisual<cr>
let g:ctrlp_tjump_shortener = ['/Users/.*/gems/', '.../']

set wildignore+=*.pyc
set wildignore+=*.so
set wildignore+=*.zip

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE CONFIGURUATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  " Remove right scrollbar
  set guioptions-=r
endif

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Set the side bar size
let g:NERDTreeWinSize = 40

" Ignore *.pyc files
let NERDTreeIgnore = ['\.pyc$']

" Show hidden files
let NERDTreeShowHidden = 1

" Open nerdtree when vim starts with a directory arg
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Toggle NERDTree with Leader-n
map <leader>n :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight the cursorline
set cursorline

" Set colorscheme
colorscheme jellybeans

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'
"let g:airline_section_y = airline#section#create(['%{s:ruby_version()}'])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-RSPEC CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" send output to tmux
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LOCAL OVERRIDES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

