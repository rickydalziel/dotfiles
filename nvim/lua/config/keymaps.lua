-- Key mappings converted from .vimrc

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in lazy.lua
-- vim.g.mapleader = ","

-- Navigation
-- Quickly show navigation at the root
keymap("n", "<leader>.", ":e.<CR>", opts)

-- Go to next search result
keymap("n", "<leader>n", ":cnext<CR>", opts)

-- Back to the last buffer
keymap("n", "<leader>b", ":b#<CR>", opts)

-- Reload the config (changed from F5 to source init.lua instead of vimrc)
keymap("n", "<F5>", ":source ~/.config/nvim/init.lua<CR>", opts)

-- Resize equally
keymap("n", "<leader>=", "<C-w>=", opts)

-- Ack/Ag search
vim.cmd("cnoreabbrev Ack Ack!")
keymap("n", "<Leader>f", ":Ack!<Space>")

-- Window/split management
keymap("n", "<leader>t", ":only <bar> AV<CR>", opts)
keymap("n", "<leader>v", ":Vex<CR>", opts)

-- Turn off search highlights
keymap("n", "<leader><CR>", ":noh<CR>", opts)

-- FZF file search with Ctrl+P
keymap("n", "<c-p>", ":Files<CR>", opts)

-- Substitute selected text
keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')

-- Search for selected text
keymap("v", "<C-s>", '"hy/<C-r>h<CR>')

-- RSpec mappings
keymap("n", "<Leader>r", ":call RunCurrentSpecFile()<CR>", opts)
keymap("n", "<Leader>e", ":call RunNearestSpec()<CR>", opts)
keymap("n", "<Leader>w", ":call RunLastSpec()<CR>", opts)

-- Only window
keymap("n", "<Leader>o", ":only<CR>", opts)
