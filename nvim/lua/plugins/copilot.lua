return {
  "github/copilot.vim",
  event = "VimEnter",
  config = function()
    -- Use Node 22 for Copilot
    vim.g.copilot_node_command = "/home/ricky/.nvm/versions/node/v22.21.1/bin/node"

    -- Disable default Tab mapping (we'll use Ctrl+Space instead)
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- Map Ctrl+Space to accept Copilot suggestion
    vim.keymap.set("i", "<C-Space>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })

    -- Optional: Additional Copilot keybindings
    -- vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
    -- vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")
  end,
}
