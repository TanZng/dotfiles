return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    -- Switch back to the old Which-Key layout
    opts.preset = "modern"
    
    -- You can still keep your custom border
    opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
      border = "rounded",
    })
    
    return opts
  end,
}
