-- Just an example, supposed to be placed in /lua/custom/

local M = {}

M.ui = {
   theme = "catppuccin",
   transparency = true,
}

M.plugins = {
   override = {
      ["kyazdani42/nvim-tree.lua"] = {
         open_on_setup = true,
         ignore_ft_on_setup = {},
         git = {
             enable = true,
         },
         renderer = {
             highlight_git = true,
             icons = {
               show = {
                  git = true,
               },
             },
         },
      },
      ["nvim-treesitter/nvim-treesitter"] = {
         ensure_installed = {
             "go",
         },
      },
   },
   user = {
      ["kyazdani42/nvim-tree.lua"] = {
         after = "nvim-web-devicons",
      },
      ["folke/which-key.nvim"] = {
         disable = false,
      },
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
