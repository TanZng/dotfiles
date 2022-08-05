-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.treesitter = {
   ensure_installed = {
      "go",
   },
}

M.nvimtree = {
   open_on_setup = true,
   filters = {
      dotfiles = true,
   },
   git = {
      enable = true,
      ignore = false,
   },
   view = {
      width = 20,
      hide_root_folder = false,
   },
   renderer = {
      highlight_git = true,
   },  
   icons = {
      show = {
        git = true,
      },
   },
}

M.ui = {
   theme = "catppuccin",
   transparency = true,
}

M.plugins = {
   user = {
      ["goolord/alpha-nvim"] = {
         disable = false,
      },
      ["neovim/nvim-lspconfig"] = {
         config = function()
           require "plugins.configs.lspconfig"
           require "custom.plugins.lspconfig"
         end,
       },
       ["jose-elias-alvarez/null-ls.nvim"] = {
         after = "nvim-lspconfig",
         config = function()
           require "custom.plugins.null-ls"
         end,
       },
   },
}

return M
