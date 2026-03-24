#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
PLATFORM="$("${SCRIPT_DIR}/detect_os.sh")"

resolve_brew() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return 0
  fi

  local candidate
  for candidate in \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew \
    "${HOME}/.linuxbrew/bin/brew"; do
    if [[ -x "${candidate}" ]]; then
      echo "${candidate}"
      return 0
    fi
  done

  return 1
}

install_homebrew() {
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

case "${PLATFORM}" in
  macos)
    if ! resolve_brew >/dev/null 2>&1; then
      install_homebrew
    fi
    ;;
  wsl)
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y \
        build-essential \
        curl \
        direnv \
        docker.io \
        file \
        gcc \
        git \
        libbz2-dev \
        libedit-dev \
        libffi-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        llvm \
        make \
        neovim \
        openssl \
        procps \
        python-is-python3 \
        python3 \
        python3-full \
        python3-pip \
        tk-dev \
        tmux \
        tree \
        wget \
        xz-utils \
        zlib1g-dev \
        zsh

    sudo apt autoremove -y

    if ! resolve_brew >/dev/null 2>&1; then
      install_homebrew
    fi

    if command -v zsh >/dev/null 2>&1 && [[ "${SHELL:-}" != "$(command -v zsh)" ]]; then
      sudo chsh -s "$(command -v zsh)" "${USER}"
    fi
    ;;
esac

mkdir -p "${HOME}/Documents/repository"

if BREW_BIN="$(resolve_brew)"; then
  eval "$("${BREW_BIN}" shellenv)"
fi

echo "Bootstrap completed for ${PLATFORM}."
