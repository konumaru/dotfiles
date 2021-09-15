# dotfiles

![GitHub Repo stars](https://img.shields.io/github/stars/konumaru/dotfiles?style=social)
![GitHub](https://img.shields.io/github/license/konumaru/dotfiles?style=flat-square)
[![Monthly Backup](https://github.com/konumaru/dotfiles/actions/workflows/monthly-backup.yml/badge.svg?event=workflow_dispatch)](https://github.com/konumaru/dotfiles/actions/workflows/monthly-backup.yml)

## Install required tools

- Command line tools for xcode
- [Homebrew](https://brew.sh/index_ja)
- [Zinit](https://github.com/zdharma/zinit)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [dein.vim](https://github.com/Shougo/dein.vim)

## Usage

### Mac

```sh
bash -c "$(curl -L https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/setup.sh)"
```

### Windows

Required operations in advance:

- Change font of powershell `Consolas` to `MS ゴシック`
  - This is the operation required to display Japanese.

```ps1
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/setup.ps1')
```

#### Manual required setup

- WSL
- Font (Cascadia Code PL), from [here](!https://github.com/microsoft/cascadia-code/releases)
- Studio One

## Description for setting files

- [Homebrew](Brewfile)
- [iterm2](com.googlecode.iterm2.plist)
  - ![iterm2_setting](img/iterm2_setting.png)
- zsh
  - [zshrc](.zshrc)
  - [zprofile](.zprofile)
- [neovim](nvim)
