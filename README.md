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

- [Install Nerd Fonts](https://www.nerdfonts.com/)
  - [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip)

## Daily Commands

```sh
make bootstrap   # install platform prerequisites and Homebrew
make sync        # apply Brewfiles and deploy dotfiles
make brewfile    # dump the current platform Brewfile
```

