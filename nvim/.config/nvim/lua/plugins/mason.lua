---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "json-lsp",
        "yaml-language-server",
        "python-lsp",
        "lua_ls",
        "bash-language-server",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "jsonls",
        "yamlls",
        "pyright",
        "lua_ls",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "gofmt",
        "prettier",
        "black",
        "stylua",
      },
    },
  },
}