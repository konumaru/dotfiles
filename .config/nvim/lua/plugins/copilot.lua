return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
          },
        },
        panel = { enabled = true },
        filetypes = {
          markdown = true,
          python = true,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = { "InsertEnter", "LspAttach" },
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    config = function()
      require("copilot_cmp").setup()
      -- copilot-cmp master still calls `client.is_stopped()` (dot call), which Nvim 0.11+ reports as
      -- deprecated on every startup. Re-implement `is_available` with the method call until
      -- zbirenbaum/copilot-cmp#133 (or an equivalent fix) is merged.
      local ok, source = pcall(require, "copilot_cmp.source")
      if ok then
        source.is_available = function(self)
          local client = self.client
          if not client or client:is_stopped() then
            return false
          end
          local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf(), id = client.id })
          return next(clients) ~= nil
        end
      end
    end,
  },
}
