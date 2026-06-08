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
