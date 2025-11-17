return {
  "mileszs/ack.vim",
  config = function()
    vim.g.ackprg = "ag --path-to-ignore ~/.ignore --nogroup --column"
    vim.g.ag_working_path_mode = "r"
  end,
}
