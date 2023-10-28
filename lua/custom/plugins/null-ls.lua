return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    require("mason").setup()
    local formatting = require('null-ls').builtins.formatting

    require('null-ls').setup {
      debug = false,
      sources = {
        formatting.prettier,
      },
    }

    require("mason-null-ls").setup({
      ensure_installed = { "black" },
      automatic_installation = true,
    })
  end,
}
