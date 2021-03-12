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
Plugin 'jgdavey/tslime.vim'
Plugin 'tpope/vim-vinegar'

" Display + general formatting
Plugin 'ervandew/supertab'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive' " Git functionality
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'

" Heelpful plugins
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-endwise' " Add ends to ruby blocks
Plugin 'tpope/vim-projectionist'
Plugin 'neomake/neomake'

" Language specific syntax and formatting
Plugin 'tpope/vim-rails'
Plugin 'yuezk/vim-js'
Plugin 'maxmellon/vim-jsx-pretty'
" Plugin 'spellman/vim-minitest'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'fatih/vim-go'
" Plugin 'justinmk/vim-syntax-extra' " C syntax improvements
" Plugin 'dense-analysis/ale'

call vundle#end()

runtime macros/matchit.vim

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
  autocmd FileType netrw call s:RemoveNetrwMap()
augroup END
" ================

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufWritePre * call <SID>StripTrailingWhitespaces()
autocmd! BufReadPost,BufWritePost * Neomake

set synmaxcol=128
syntax sync minlines=256
set shell=/bin/bash
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast="high"
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
set clipboard+=unnamedplus
set tags=tags,./tags

" let g:netrw_sort_options = "i"
" let g:netrw_banner = 0
" let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'

let g:vim_jsx_pretty_highlight_close_tag = 0
let g:vim_jsx_pretty_template_tags = ['html', 'js', 'jsx']
let g:vim_jsx_pretty_colorful_config = 1

" Use ag instead of grep
set grepprg=ag\ --nogroup\ --nocolor
let g:ackprg = 'ag --path-to-ignore ~/.ignore --nogroup --column'
let g:ag_working_path_mode="r"

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ],
      \'right': [ [ 'lineinfo' ],
      \           [ 'filetype'],
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


let g:projectionist_ignore_term = 1
let g:projectionist_heuristics = {
      \ "src/*.js": {
      \    "alternate": "test/{}Spec.js"
      \  },
      \  "spec/*Spec.js": {
      \    "alternate": "src/{}.js"
      \  }
\}

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
call neomake#configure#automake('w')

let mapleader = ","
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
let g:rspec_runner = "os_x_iterm"

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
nmap <F5> :so ~/.vimrc<CR>
" Resize equally
nmap <leader>= <C-w>=
" Fast Search
nmap <leader>f :Ag<space>

nmap <leader>t :only <bar> AV<CR>
nmap <leader>v :Vex<CR>

" turn of search highlights
nnoremap <leader><CR> :noh<CR>

" setup fzf to control + p
nnoremap <c-p> :Files<CR>

" substitute selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>e :call RunNearestSpec()<CR>
map <Leader>w :call RunLastSpec()<CR>
map <Leader>o :only<CR>

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

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
  if winwidth(0) > 120
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

function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

function s:RemoveNetrwMap()
  if hasmapto('<Plug>NetrwRefresh')
    unmap <buffer> <C-l>
  endif
endfunction
