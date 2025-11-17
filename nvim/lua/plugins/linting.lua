return {
  "dense-analysis/ale",
  config = function()
    vim.g.ale_fix_on_save = 1
    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      ruby = { "standardrb" },
      javascript = { "standard" },
      css = { "stylelint" },
      eruby = { "erblint" },
    }
    vim.g.ale_linters = {
      ruby = { "standardrb" },
      css = { "stylelint" },
      javascript = { "standard" },
      eruby = { "erblint" },
    }

    -- ALEToggleFixer command
    vim.api.nvim_create_user_command("ALEToggleFixer", function()
      vim.g.ale_fix_on_save = vim.g.ale_fix_on_save == 1 and 0 or 1
    end, {})
  end,
}
