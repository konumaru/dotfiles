return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        icons_enabled = vim.g.have_nerd_font,
        component_separators = vim.g.have_nerd_font and { left = "", right = "" } or { left = "|", right = "|" },
        section_separators = vim.g.have_nerd_font and { left = "", right = "" } or { left = "", right = "" },
      },
    },
  },
}
