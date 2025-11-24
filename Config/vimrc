" --- Initialization & Plugins ---
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'maralla/completor.vim'
Plugin 'yggdroot/indentline'
Plugin 'matze/vim-move'
Plugin 'rhysd/vim-clang-format'

call vundle#end()
filetype plugin indent on
runtime! plugin/sensible.vim

" --- General Settings ---
set encoding=utf-8 fileencodings=
syntax on
set autowrite
set autoread
set wildmenu
set backspace=indent,eol,start

let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
    exe "set" git_settings
endif

" --- User Interface ---
set number
set cc=80
set scrolloff=10
set showmatch
set list listchars=tab:»·,trail:·
let g:termdebug_wide=1

" --- Indentation ---
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
autocmd Filetype make setlocal noexpandtab

" --- Search Settings ---
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <C-l> :noh<CR>

" --- Mappings & Shortcuts ---
nnoremap <C-x> :wq<CR>
inoremap <C-x> <Esc>:wq<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>i
nnoremap <C-q> :q!<CR>
inoremap <C-q> <Esc>:q!<CR>

inoremap <C-u> <Esc>:u<CR>i
nnoremap <C-u> :u<CR>
inoremap <C-y> <Esc>:redo<CR>i
nnoremap <C-y> :redo<CR>

vnoremap <C-c> y
vnoremap <C-v> p
inoremap <C-v> <Esc>vp<Esc>i
vnoremap cc "+y
vnoremap <BS> d

nnoremap < gT
nnoremap > gt
nnoremap + :tabe<CR>

nnoremap <C-f> :ClangFormat<CR>
inoremap <C-f> <Esc>:ClangFormat<CR>i
inoremap <C-t> <Esc>:NERDTreeToggle<CR>i
nnoremap <C-t> :NERDTreeToggle<CR>

:inoremap { {}<Left>

:inoremap @for for (size_t i = 0; i < ; i++)<CR><BS>{<CR><BS>}<Left><CR><Up><Tab><Up><Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>
:inoremap @jfor for (size_t j = 0; j < size; j++)<CR><BS>{<CR><BS>}<Left><CR><Up><Tab>
:inoremap @kfor for (size_t k = 0; k < size; k++)<CR><BS>{<CR><BS>}<Left><CR><Up><Tab>
:inoremap @while while ()<CR><BS>{<CR><BS>}<Up><CR>a<BS><Up><Up><Right><Right><Right>
:inoremap @if if ()<CR><BS>{<CR><BS>}<Up><CR>a<BS><Up><Up>
:inoremap @elif else if ()<CR><BS>{<CR><BS>}<Up><CR>a<BS><Up><Up><Right><Right><Right><Right><Right>
:inoremap @else else<CR><BS>{<CR><BS>}<Up><CR>a<BS>
:inoremap @marg int main(int argc, char *argv[])<CR><BS>{<CR><BS>}<Left><CR><Up><Tab>return 0;<Up><CR>
::noremap @main int main(void)<CR><BS>{<CR><BS>}<Left><CR><Up><Tab>return 0;<Up><CR>
:inoremap @pf printf("\n");<Left><Left><Left><Left><Left>
:inoremap @struct struct <CR>{<CR>};<Up><Up><Right><Right><Right><Right><Right>

" --- Colors & Highlights ---
highlight Search cterm=bold ctermfg=lightblue ctermbg=NONE
highlight IncSearch cterm=bold,underline ctermfg=lightblue ctermbg=NONE
highlight SpellBad cterm=bold ctermfg=red ctermbg=NONE
highlight QuickFixLine cterm=NONE ctermfg=white
highlight ColorColumn term=NONE cterm=NONE ctermbg=darkgrey ctermfg=white
highlight CurSearch NONE
highlight DiffChange NONE
highlight SpellRare NONE
highlight Pmenu cterm=NONE ctermfg=white ctermbg=236
highlight MatchParen cterm=NONE ctermfg=lightblue ctermbg=NONE
highlight SignColumn NONE
highlight SpellCap cterm=bold ctermfg=yellow ctermbg=black
highlight Statement cterm=bold ctermfg=darkyellow
highlight SyntasticWarningSign cterm=bold ctermfg=yellow ctermbg=black
highlight SyntasticErrorSign cterm=bold ctermfg=red ctermbg=black
highlight vimError cterm=bold ctermfg=red ctermbg=black
highlight LineNr cterm=NONE ctermfg=darkcyan

autocmd FileType * highlight Statement cterm=bold ctermfg=darkyellow
autocmd FileType * highlight LineNr cterm=NONE ctermfg=darkgrey

" --- Plugin Configuration ---
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_c_config_file='~/afs/.confs/vim/.syntastic_c_config_file'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:indentLine_char = '|'
let g:indentLine_color_term = 239
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1

let g:move_key_modifier = 'C'

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#enable_fallback_style = 0

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" --- Auto Commands ---
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

