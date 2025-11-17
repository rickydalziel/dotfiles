-- General vim options converted from .vimrc

-- Compatibility and basic settings
vim.opt.compatible = false
vim.opt.shell = "/bin/bash"

-- Display settings
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = false -- disabled because lightline shows mode
vim.opt.wrap = false
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.ttyfast = true
vim.opt.lazyredraw = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation and tabs
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Editing behavior
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.history = 500
vim.opt.autoread = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- List characters for whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = "  ",
  trail = ".",
  extends = ">",
  precedes = "<"
}

-- Syntax and performance
vim.opt.synmaxcol = 250
vim.cmd("syntax sync minlines=256")

-- Tags
vim.opt.tags = "tags,./tags"

-- Grep program
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --color=never"
else
  vim.opt.grepprg = "ag --nogroup --nocolor"
end

-- Enable syntax and filetype detection
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Load matchit macro
vim.cmd("runtime macros/matchit.vim")

-- Colorscheme settings (with error protection)
vim.g.solarized_termtrans = 1
vim.g.solarized_contrast = "high"

-- Try to load colorscheme, but don't fail if it's not available
local ok, _ = pcall(vim.cmd, "colorscheme solarized")
if ok then
  -- Highlight settings (only if colorscheme loaded successfully)
  vim.cmd("highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse")
  vim.cmd("highlight link multiple_cursors_visual Visual")
  vim.cmd("highlight LineNr ctermbg=NONE")
end
