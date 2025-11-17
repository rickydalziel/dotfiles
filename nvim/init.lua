-- Load lightline config before lazy (needs to be set before plugin loads)
require("config.lightline")

-- Load lazy.nvim plugin manager
require("config.lazy")

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- tslime configuration
vim.g.tslime_always_current_session = 1
vim.g.tslime_always_current_window = 1

-- CtrlP/FZF configuration
if vim.fn.executable("rg") == 1 then
  vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  vim.g.ctrlp_use_caching = 0
else
  vim.g.ctrlp_clear_cache_on_exit = 0
end

-- FZF runtime path
vim.opt.rtp:append("/usr/bin/fzf")
