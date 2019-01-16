call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive' " Git
Plug 'junegunn/vim-easy-align'
"Plug 'tpope/vim-sleuth'
" Theme
Plug 'joshdick/onedark.vim'
" Languages
Plug 'w0rp/ale' " lint
Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'davidhalter/jedi-vim' " Python autocomplete
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold' " Python folding
Plug 'artur-shaik/vim-javacomplete2'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'OrangeT/vim-csharp'
Plug 'webastien/vim-ctags'

call plug#end()

" Defaults

syntax on
filetype plugin indent on

set noswapfile
set incsearch
set number
set showcmd
set nowrap

set list
set listchars=tab:>~,trail:~
set iskeyword+=-

set splitbelow
set splitright

set scrolloff=3
set nofoldenable " prevent folding on start

" shortcuts
map gb :wprevious<CR>
map gn :wnext<CR>
nnoremap ,w :%s/\s\+$//<CR>

if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo")
	call mkdir($HOME."/.vim/undo", "", 0700)
endif

set undodir=~/.vim/undo
set undofile

" Theme

colorscheme onedark
let g:gruvbox_contrast_dark = 'hard'
set guioptions-=m " remove menu
set guioptions-=T " remove toolbar

" Plugin configurations

set wildignore+=*/tmp/*,*/node_modules/*,*/.eggs/*
let g:ctrlp_match_window = 'max:20'
let g:ctrlp_show_hidden = 1

nnoremap ,, :CtrlP<CR>
nnoremap ,. :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap ,d :diffupdate<CR>
nnoremap ,u :UndotreeToggle<CR>

xmap ga <Plug>(EasyAlign) " Start interactive EasyAlign in visual mode (e.g. vipga)
nmap ga <Plug>(EasyAlign) " Start interactive EasyAlign for a motion/text object (e.g. gaip)

" File type patches

autocmd FileType java setlocal omnifunc=javacomplete#Complete
au BufNewFile,BufRead *.jbuilder setf ruby
au BufNewFile,BufRead *.json.jbuilder setf ruby
au BufNewFile,BufRead *.json setf javascript
au BufNewFile,BufRead *.slim setf slim
au BufNewFile,BufRead *.html.slim setf slim

" Lint

let g:ale_linters = {
\ 'javascript': ['eslint'],
\}

" E501: line too long
" W503: line ending before operator
" E261: two spaces before inline comment
" E241: multiple spaces after ':' (formatted dict)
" E272: multiple spaces before keyword (formatted dict)
" E402: module level import not at the top of file
let g:ale_python_flake8_options = "--ignore=E501,W503,E261,E241,E272,E402"

" Language configuration
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 0 " disable 'from X ' automatically typing 'import'

let g:JavaComplete_ImportSortType = 'packageName'

let g:ale_ruby_rubocop_options = "--except "
  + "Metrics/BlockLength,"
  + "Metrics/LineLength,"
  + "Style/MutableConstant,"
  + "Style/NegatedIf,"
  + "Style/Not,"
  + "Style/StringLiterals,"
  + "Style/TrailingCommaInLiteral,"
  + "Style/WordArray"

let g:ale_javascript_eslint_options = "--config ".$HOME."/.vim/.eslintrc.yml"

let g:go_gocode_unimported_packages = 1
let g:go_fmt_command = $HOME."/go/bin/goreturns"
