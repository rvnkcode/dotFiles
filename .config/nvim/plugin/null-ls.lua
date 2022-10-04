local null_ls = require("null-ls")
-- code action sources
local code_actions = null_ls.builtins.code_actions
-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics
-- formatting sources
local formatting = null_ls.builtins.formatting
-- hover sources
-- local hover = null_ls.builtins.hover
-- completion sources
local completion = null_ls.builtins.completion

-- register any number of sources simultaneously
local sources = {
  completion.luasnip,
  -- for web
  code_actions.eslint,
  diagnostics.eslint,
  formatting.prettier,
  -- lua
  -- formatting.stylua,
  -- diagnostics.luacheck,
  -- markdown and other writings
  diagnostics.markdownlint,
  formatting.markdownlint,
  formatting.codespell,
  diagnostics.write_good,
  -- others
  -- formatting.xmlformatter
  code_actions.gitsigns,
}

null_ls.setup({ sources = sources })
