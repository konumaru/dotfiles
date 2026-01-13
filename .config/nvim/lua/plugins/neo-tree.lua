return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      window = {
        position = "right",
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      -- Accept legacy "-tree" arg by translating it to the filesystem source.
      local command = require("neo-tree.command")
      vim.api.nvim_create_user_command("Neotree", function(ctx)
        local args = {}
        for _, arg in ipairs(ctx.fargs) do
          if arg == "-tree" then
            table.insert(args, "filesystem")
          else
            table.insert(args, arg)
          end
        end
        command._command(unpack(args))
      end, {
        nargs = "*",
        complete = "custom,v:lua.require'neo-tree.command'.complete_args",
        force = true,
      })
    end,
  },
}
