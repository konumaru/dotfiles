local augroup = vim.api.nvim_create_augroup("KonumaruNvim", { clear = true })

local function autosave(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return
  end
  if vim.bo[bufnr].readonly or not vim.bo[bufnr].modifiable then
    return
  end
  if vim.api.nvim_buf_get_name(bufnr) == "" then
    return
  end
  if not vim.bo[bufnr].modified then
    return
  end
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd("silent update")
  end)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  group = augroup,
  callback = function(args)
    autosave(args.buf)
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
    local formatoptions = vim.bo.formatoptions
    if not formatoptions:find("r", 1, true) then
      formatoptions = formatoptions .. "r"
    end
    if not formatoptions:find("o", 1, true) then
      formatoptions = formatoptions .. "o"
    end
    if not formatoptions:find("n", 1, true) then
      formatoptions = formatoptions .. "n"
    end
    vim.bo.formatoptions = formatoptions

    local comments = vim.bo.comments
    local function add_comment_leader(leader)
      if not comments:find(leader, 1, true) then
        comments = comments .. (comments == "" and "" or ",") .. leader
      end
    end

    add_comment_leader("b:-")
    add_comment_leader("b:+")
    add_comment_leader("b:*")
    vim.bo.comments = comments
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
