return {
  "thoughtbot/vim-rspec",
  config = function()
    vim.g.rspec_command = 'call Send_to_Tmux("rspec {spec}\\n")'
    vim.g.rspec_runner = "os_x_iterm"
  end,
}
