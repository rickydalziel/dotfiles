set nocompatible               " Round here we say Vim, not Vi
filetype off                   " required!

set rtp+=/usr/bin/fzf

call plug#begin('~/.vim/plugged')

" Navigation + Searching
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jgdavey/tslime.vim'
Plug 'tpope/vim-vinegar'
Plug 'ggandor/leap.nvim'
Plug 'mileszs/ack.vim'

" Display + general formatting
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive' " Git functionality
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'

" Heelpful plugins
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-endwise' " Add ends to ruby blocks
Plug 'tpope/vim-projectionist'
Plug 'dense-analysis/ale'

" Language specific syntax and formatting
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

call plug#end()

runtime macros/matchit.vim

" ================
"  Ruby stuff
" ================
syntax on
filetype plugin indent on
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  autocmd BufWritePre * call <SID>StripTrailingWhitespaces()
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  autocmd FileType c,cpp set sw=2 sts=8 nolist noexpandtab
  " autocmd FileType c,cpp setl nolist autoindent cindent
  autocmd FileType netrw call s:RemoveNetrwMap()
  autocmd FileType netrw call lightline#update()
augroup END
" ================

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

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

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['standardrb'],
\   'javascript': ['standard'],
\   'css': ['stylelint'],
\   'eruby': ['erblint'] }
let g:ale_linters = {
\   'ruby': ['standardrb'],
\   'css': ['stylelint'],
\   'javascript': ['standard'],
\   'eruby': ['erblint']   }

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
" Go to next search result
nmap <leader>n :cnext<CR>
" Back to the last buffer
nmap <leader>b :b#<CR>
" Reload the vimrc config
nmap <F5> :so ~/.vimrc<CR>
" Resize equally
nmap <leader>= <C-w>=
cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>

nmap <leader>t :only <bar> AV<CR>
nmap <leader>v :Vex<CR>

" turn of search highlights
nnoremap <leader><CR> :noh<CR>

" setup fzf to control + p
nnoremap <c-p> :Files<CR>

" substitute selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

vnoremap <C-s> "hy/<C-r>h<CR>

map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>e :call RunNearestSpec()<CR>
map <Leader>w :call RunLastSpec()<CR>
map <Leader>o :only<CR>
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

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

function s:RemoveNetrwMap()
  if hasmapto('<Plug>NetrwRefresh')
    unmap <buffer> <C-l>
  endif
endfunction

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

lua require('leap').add_default_mappings()
