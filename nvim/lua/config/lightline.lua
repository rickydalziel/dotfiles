-- Lightline configuration
-- This needs to be set before lightline loads

-- Define lightline helper functions first
vim.cmd([[
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
]])

-- Configure lightline
vim.g.lightline = {
  active = {
    left = {
      { "mode", "paste" },
      { "fugitive", "filename" },
    },
    right = {
      { "lineinfo" },
      { "filetype" },
      { "percent" },
    },
  },
  component_function = {
    fugitive = "MyFugitive",
    modified = "MyModified",
    filename = "MyFilename",
  },
  separator = { left = "", right = "" },
  subseparator = { left = "|", right = "|" },
}
