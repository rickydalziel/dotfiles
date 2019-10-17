set nocompatible               " Round here we say Vim, not Vi
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()

" Vundle
Plugin 'VundleVim/Vundle.vim'

" Navigation + Searching
Plugin 'rking/ag.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-vinegar' " Directory management

" Display + general formatting
Plugin 'ervandew/supertab'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive' " Git functionality
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'

" Language specific syntax and formatting
Plugin 'tpope/vim-rails'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'thoughtbot/vim-rspec'
" Plugin 'spellman/vim-minitest'
Plugin 'tpope/vim-endwise' " Add ends to ruby blocks
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'fatih/vim-go'
" Plugin 'maxmellon/vim-jsx-pretty'
" Plugin 'rhysd/vim-clang-format'
" Plugin 'hashivim/vim-terraform'
" Plugin 'justinmk/vim-syntax-extra' " C syntax improvements
"
Plugin 'dense-analysis/ale'
Plugin 'nikvdp/ejs-syntax'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'chemzqm/vim-jsx-improve'

call vundle#end()

" ================
"  Ruby stuff
" ================
syntax on
filetype plugin indent on
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  autocmd FileType c,cpp set sw=2 sts=8 nolist noexpandtab
  " autocmd FileType c,cpp setl nolist autoindent cindent
augroup END
" ================

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set shell=/bin/bash
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:ruby_refactoring_map_keys=0
colorscheme solarized
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
highlight LineNr ctermbg=NONE
set noshowmode
set hlsearch
set incsearch
set lazyredraw
set cursorline
set ttyfast

" Use ag instead of grep
set grepprg=ag\ --nogroup\ --nocolor
let g:ackprg = 'ag --path-to-ignore ~/.ignore --nogroup --column'

let g:ag_working_path_mode="r"

" Set specific linters
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \   'javascript': ['eslint']
      \}

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ],
      \'right': [ [ 'lineinfo' ],
      \            [ 'percent' ]]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ }

let mapleader = ","
let g:go_fmt_command = "goimports"
" let g:rspec_command = "!bundle exec rspec {spec}"
let g:clang_format#detect_style_file = 1
" Basic config that I cannot live without
set list
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=500                 " keep 500 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set autoindent
set showmatch
set number
set nowrap
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set autoread
set ttimeout
set laststatus=2
set ttimeoutlen=0

" List chars show whitespace and do not wrap lines
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<
set synmaxcol=250

" Qucikly show navigation at the root
nmap <leader>. :e.<CR>
" Back to the last buffer
nmap <leader>b :b#<CR>
" Reload the vimrc config
nmap <F5> :so $MYVIMRC<CR>
" Resize equally
nmap <leader>= <C-w>=
" Fast Search
nmap <leader>f :Ag

nmap <leader>t :only <bar> AV<CR>
nmap <leader>v :Vex<CR>

" turn of search highlights
nnoremap <leader><CR> :noh<CR>

" setup fzf to control + p
nnoremap <c-p> :Files<CR>

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>e :call RunNearestSpec()<CR>
map <Leader>w :call RunLastSpec()<CR>

" map <Leader>r :Rake<CR>

map <Leader>l :RExtractLet<CR>
map <Leader>o :only<CR>

autocmd BufWritePre * :%s/\s\+$//e

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if winwidth(0) > 100
    if exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? "\ue0a0 "._ : ''
    endif
  endif
  return ''
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
