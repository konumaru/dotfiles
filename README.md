# dotfiles

![GitHub](https://img.shields.io/github/license/konumaru/dotfiles?style=flat-square)

## Install required tools

- Command line tools for xcode
- [Homebrew](https://brew.sh/index_ja)
- [Zinit](https://github.com/zdharma/zinit)
- [dein.vim](https://github.com/Shougo/dein.vim)

## How To Setup

Mac

```sh
bash -c "$(curl -LsS https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/install.sh)"
```

Ubuntu (WSL)

```sh
bash -c "$(wget -qO - https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/install.sh)"
```

Windows

```ps1
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/konumaru/dotfiles/main/bin/install.ps1')
```

## Manual optional setup

Change the remote url to ssh.

```sh
git remote set-url origin git@github.com:konumaru/dotfiles.git
```
