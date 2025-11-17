-- Autocommands converted from .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Ruby and other filetypes group
local myfiletypes = augroup("myfiletypes", { clear = true })

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  group = myfiletypes,
  pattern = "*",
  callback = function()
    require("config.functions").StripTrailingWhitespaces()
  end,
})

-- Ruby, eruby, yaml settings
autocmd("FileType", {
  group = myfiletypes,
  pattern = { "ruby", "eruby", "yaml" },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- C, C++ settings
autocmd("FileType", {
  group = myfiletypes,
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 8
    vim.opt_local.list = false
    vim.opt_local.expandtab = false
  end,
})

-- Netrw settings
autocmd("FileType", {
  group = myfiletypes,
  pattern = "netrw",
  callback = function()
    require("config.functions").RemoveNetrwMap()
    vim.cmd("call lightline#update()")
  end,
})

-- Markdown filetype detection
autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

-- XML formatting
autocmd("FileType", {
  pattern = "xml",
  callback = function()
    vim.opt_local.equalprg = "xmllint --format --recover - 2>/dev/null"
  end,
})
