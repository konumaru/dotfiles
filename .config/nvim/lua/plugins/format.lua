return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "python" or ft == "markdown" then
          return { lsp_fallback = true, timeout_ms = 2000 }
        end
        return
      end,
      formatters_by_ft = {
        python = { "ruff_format" },
        markdown = { "prettierd", "prettier" },
      },
    },
  },
}

