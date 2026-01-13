return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ok, config = pcall(require, "nvim-treesitter.config")
      if ok then
        config.setup(opts)
        return
      end

      local ok_legacy, configs = pcall(require, "nvim-treesitter.configs")
      if ok_legacy then
        configs.setup(opts)
      end
    end,
  },
}
