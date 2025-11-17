return {
  -- JavaScript
  {
    "yuezk/vim-js",
    ft = { "javascript", "javascriptreact", "javascript.jsx" },
  },
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "javascript.jsx" },
    init = function()
      vim.g.vim_jsx_pretty_highlight_close_tag = 0
      vim.g.vim_jsx_pretty_template_tags = { "html", "js", "jsx" }
      vim.g.vim_jsx_pretty_colorful_config = 1
    end,
  },

  -- Ruby
  "vim-ruby/vim-ruby",
}
