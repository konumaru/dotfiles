local map = vim.keymap.set

map("i", "jj", "<Esc>")

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Explorer (Oil)" })

map("n", "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Git reset hunk" })

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

map("n", "<leader>f", function()
  local ok, conform = pcall(require, "conform")
  if not ok then
    return
  end
  conform.format({ lsp_fallback = true, timeout_ms = 2000 })
end, { desc = "Format" })
