return {
  "akinsho/toggleterm.nvim",
  opts = function(_, opts)
    opts.float_opts = vim.tbl_deep_extend("force", opts.float_opts or {}, {
      border = "curved",
    })
    return opts
  end,
}
