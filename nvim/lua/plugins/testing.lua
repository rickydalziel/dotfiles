return {
  "thoughtbot/vim-rspec",
  config = function()
    -- {spec} may be an absolute path; rewrite it to a project-root-relative
    -- path (spec/...) so it resolves inside the devcontainer that `dce` runs in.
    vim.g.rspec_command = [[call Send_to_Tmux("dce rspec $(echo {spec} | sed 's#^.*/spec/#spec/#')\n")]]
    vim.g.rspec_runner = "os_x_iterm"
  end,
}
