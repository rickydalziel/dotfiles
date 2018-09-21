set nocompatible               " Round here we say Vim, not Vi
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-unimpaired'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'nono/vim-handlebars'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-endwise'
Plugin 'itchyny/lightline.vim'
Plugin 'mxw/vim-jsx'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'kentaroi/cocoa.vim'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'thoughtbot/vim-rspec'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'tmhedberg/matchit'
Plugin 'rhysd/vim-clang-format'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tomtom/tcomment_vim'
Plugin 'spellman/vim-minitest'

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
let g:ackprg = 'ag --nogroup --column'
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0


let g:lightline = {
      \ 'colorscheme': 'solarized',
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
let g:rspec_command = "!bundle exec zeus rspec {spec}"
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
nmap <leader>f :Ack

nmap <leader>t :only <bar> AV<CR>
nmap <leader>v :Vex<CR>

" turn of search highlights
nnoremap <leader><CR> :noh<CR>

" map <Leader>r :call RunCurrentSpecFile()<CR>
" map <Leader>e :call RunNearestSpec()<CR>
" map <Leader>w :call RunLastSpec()<CR>

map <Leader>r :Rake<CR>

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
