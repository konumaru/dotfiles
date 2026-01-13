local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function bootstrap_lazy()
  if vim.env.NVIM_SKIP_BOOTSTRAP == "1" then
    return vim.loop.fs_stat(lazypath) ~= nil
  end

  if vim.loop.fs_stat(lazypath) then
    return true
  end

  if vim.fn.executable("git") ~= 1 then
    vim.notify("lazy.nvim bootstrap skipped: `git` not found", vim.log.levels.WARN)
    return false
  end

  vim.notify("Installing lazy.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install lazy.nvim (network?)", vim.log.levels.ERROR)
    return false
  end

  return true
end

if bootstrap_lazy() then
  vim.opt.rtp:prepend(lazypath)
end

local ok, lazy = pcall(require, "lazy")
if not ok then
  return
end

lazy.setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = { enabled = true },
  ui = {
    border = "rounded",
  },
})

