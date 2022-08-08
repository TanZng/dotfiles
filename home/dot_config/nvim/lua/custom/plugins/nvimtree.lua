local M = {}

M.config = function ()
   local nvimtree = require("nvim-tree")
   local config = {
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
   }

   nvimtree.setup(config)
end

return M