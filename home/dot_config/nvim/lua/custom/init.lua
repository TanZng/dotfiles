-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

local fn = vim.fn
local g = vim.g

if fn.has "wsl" == 1 then
  g.clipboard = {
      copy = {
        ["+"] = "/mnt/c/tools/neovim/nvim-win64/bin/win32yank.exe -i --crlf",
        ["*"] = "/mnt/c/tools/neovim/nvim-win64/bin/win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "/mnt/c/tools/neovim/nvim-win64/bin/win32yank.exe -o --lf",
        ["*"] = "/mnt/c/tools/neovim/nvim-win64/bin/win32yank.exe -o --lf",
      },
    }
end

g.transparent_enabled = true
