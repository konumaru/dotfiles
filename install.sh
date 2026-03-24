#!/bin/bash

set -euo pipefail

DOTPATH="${HOME}/dotfiles"
GITHUB_URL="https://github.com/konumaru/dotfiles"

clone_dotfiles() {
  if [[ -d "${DOTPATH}" ]]; then
    echo "Already exists ${DOTPATH}"
    exit 1
  fi

  if command -v git >/dev/null 2>&1; then
    git clone "${GITHUB_URL}.git" "${DOTPATH}"
  else
    echo "Install git!"
    exit 1
  fi
}

prepare_linux() {
  if ! command -v git >/dev/null 2>&1 || ! command -v make >/dev/null 2>&1; then
    sudo apt update -y
    sudo apt install -y git make zsh
  fi
}

case "$(uname -s)" in
  Darwin)
    echo "Running on macOS"
    ;;
  Linux)
    echo "Running on Linux"
    prepare_linux
    ;;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

clone_dotfiles

"${DOTPATH}/bin/bootstrap.sh"
make -C "${DOTPATH}" sync

command echo -e "\e[1;36m Install completed!!!! \e[m"
