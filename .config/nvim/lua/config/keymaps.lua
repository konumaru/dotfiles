local map = vim.keymap.set

map("i", "jj", "<Esc>")

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map("n", "<leader>f", function()
  local ok, conform = pcall(require, "conform")
  if not ok then
    return
  end
  conform.format({ lsp_fallback = true, timeout_ms = 2000 })
end, { desc = "Format" })
