return {
  -- add gruvbox
  {
    "f4z3r/gruvbox-material.nvim",
    opts = {
      background = {
        transparent = true,
      },
      float = {
        force_background = true,
        background_color = nil,
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
