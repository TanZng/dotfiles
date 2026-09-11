-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.color.transparent-nvim", enabled = true },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { -- further customize the options set by the community
    "catppuccin",
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      term_colors = true,
      transparent_background = true,
      default_integrations = true,
      integrations = {
        neotree = true,
        which_key = true,
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = { enabled = true },
        sandwich = false,
        noice = true,
        leap = true,
        markdown = true,
        neotest = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
        gitgraph = true,
        toggleterm = true,
        mason = true,
      },
    },
  },
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
}
