# dotfiles

![GitHub](https://img.shields.io/github/license/konumaru/dotfiles?style=flat-square)

## How To Setup

Mac

```sh
bash -c "$(curl -LsS https://raw.githubusercontent.com/konumaru/dotfiles/main/install.sh)"
```

Ubuntu (WSL)

```sh
bash -c "$(wget -qO - https://raw.githubusercontent.com/konumaru/dotfiles/main/install.sh)"
```

## Manual Setup

- Shared font definition: `etc/terminal-font.toml`
- `etc/terminal-font.toml` is the canonical value set. When you change these values, update terminal-specific files together (`.wezterm.lua`, `.alacritty.toml`, `init/windows/windows-terminal.settings.json`).
- Install JetBrainsMono Nerd Font
  - macOS
    ```sh
    bash init/macos/install_nerd_font.sh
    ```
  - Windows (PowerShell)
    ```powershell
    powershell -ExecutionPolicy Bypass -File init/windows/install_nerd_font.ps1
    ```
- Terminal font settings
  - WezTerm: `~/.wezterm.lua`
  - Alacritty: `~/.alacritty.toml`
  - Windows Terminal template: `init/windows/windows-terminal.settings.json`

## Daily Commands

```sh
make bootstrap   # install platform prerequisites and Homebrew
make sync        # apply Brewfiles and deploy dotfiles
make brewfile    # dump the current platform Brewfile
```
