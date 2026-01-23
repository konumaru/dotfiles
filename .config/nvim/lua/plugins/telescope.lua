return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set

      map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      map("n", "<leader><leader>", builtin.buffers, { desc = "Buffers" })

      map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Grep" })
      map("n", "<leader>fw", builtin.live_grep, { desc = "Grep (word)" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
    end,
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = (vim.g.have_nerd_font and " " or "> "),
          selection_caret = (vim.g.have_nerd_font and "❯ " or "> "),
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown(),
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}
