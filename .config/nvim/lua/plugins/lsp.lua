return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("KonumaruLspAttach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local builtin_ok, builtin = pcall(require, "telescope.builtin")
          if builtin_ok then
            map("gd", builtin.lsp_definitions, "Go to definition")
            map("gr", builtin.lsp_references, "References")
            map("gi", builtin.lsp_implementations, "Go to implementation")
          else
            map("gd", vim.lsp.buf.definition, "Go to definition")
            map("gr", vim.lsp.buf.references, "References")
            map("gi", vim.lsp.buf.implementation, "Go to implementation")
          end

          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          local supports = function(method)
            return client:supports_method(method, { bufnr = event.buf })
          end

          if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local group = vim.api.nvim_create_augroup("KonumaruLspHighlights", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local diagnostic_signs = vim.g.have_nerd_font and {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      } or nil

      vim.diagnostic.config({
        signs = diagnostic_signs and { text = diagnostic_signs } or {},
        virtual_text = { source = "if_many" },
        severity_sort = true,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              pythonPath = vim.fn.system('uv run which python'):gsub('\n', ''),
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              organizeImports = true,
            },
          },
        },
        marksman = {},
      }

      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "pyright",
          "ruff",
          "marksman",
          "markdownlint",
          "prettierd",
        },
        run_on_start = true,
      })

      for server_name, server_config in pairs(servers) do
        server_config = server_config or {}
        server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
        vim.lsp.config(server_name, server_config)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
