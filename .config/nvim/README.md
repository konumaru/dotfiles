# Neovim config

- Entry point: `init.lua`
- Plugin manager: `lazy.nvim` (first launch requires `git` + network)
- Nerd Font: enabled (`vim.g.have_nerd_font = true`)
- Style: inspired by `nvim-lua/kickstart.nvim` (readable defaults, sane mappings)

## Keymaps

- Search (Telescope): `<leader>sf` files, `<leader>sg` grep, `<leader>fw` grep (word), `<leader>sh` help, `<leader><leader>` buffers
- Explorer (Oil): `<leader>e`
- Explorer (Neo-tree): `<leader>n`
- Git (Diffview): `<leader>gd` diff view, `<leader>gh` file history
- Format (Conform): `<leader>f`

## Setup

- Plugins: `:Lazy sync`
- LSP/tools: `:Mason` (auto-install via `mason-tool-installer.nvim` on startup)
- Copilot: `:Copilot auth`

## Nerd Font toggle

- If your terminal can't render Nerd Font glyphs, start Neovim with `NVIM_HAVE_NERD_FONT=0 nvim` to disable icons/separators.
