-- example file i.e lua/custom/init.lua

-- load your globals, autocmds here or anything .__.

if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
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

vim.g.transparent_enabled = true
