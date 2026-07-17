return {
  "github/copilot.vim",
  event = "VimEnter",
  config = function()
    -- Automatically find the latest Node version from nvm
    local node_path = vim.fn.expand("$HOME/.nvm/versions/node")
    if vim.fn.isdirectory(node_path) == 1 then
      local versions = vim.fn.readdir(node_path, function(name)
        return vim.fn.isdirectory(node_path .. "/" .. name) == 1
      end)
      if #versions > 0 then
        table.sort(versions, function(a, b) return a > b end)
        vim.g.copilot_node_command = node_path .. "/" .. versions[1] .. "/bin/node"
      end
    end

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
