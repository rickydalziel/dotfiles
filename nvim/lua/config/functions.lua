-- Custom functions converted from .vimrc

local M = {}

-- Strip trailing whitespaces
function M.StripTrailingWhitespaces()
  -- Save last search and cursor position
  local save_search = vim.fn.getreg("/")
  local save_cursor = vim.fn.getpos(".")

  -- Strip trailing whitespace
  vim.cmd([[%s/\s\+$//e]])

  -- Restore last search and cursor position
  vim.fn.setreg("/", save_search)
  vim.fn.setpos(".", save_cursor)
end

-- Remove netrw map for Ctrl-l
function M.RemoveNetrwMap()
  if vim.fn.hasmapto("<Plug>NetrwRefresh") ~= 0 then
    vim.api.nvim_buf_del_keymap(0, "n", "<C-l>")
  end
end

-- Show syntax stack at cursor
function M.SynStack()
  if vim.fn.exists("*synstack") == 0 then
    return
  end

  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local stack = vim.fn.synstack(line, col)

  local names = {}
  for _, id in ipairs(stack) do
    table.insert(names, vim.fn.synIDattr(id, "name"))
  end

  print(vim.inspect(names))
end

return M
