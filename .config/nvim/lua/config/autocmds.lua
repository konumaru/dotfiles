local augroup = vim.api.nvim_create_augroup("KonumaruNvim", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  group = augroup,
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent write")
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
    vim.bo.textwidth = 80
    vim.wo.colorcolumn = "80"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "python" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
    vim.bo.textwidth = 88
    vim.wo.colorcolumn = "88"
  end,
})
