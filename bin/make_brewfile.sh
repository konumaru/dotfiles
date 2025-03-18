#!/bin/bash

# Exit if any command fails
set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Detect OS type
case "${OSTYPE}" in
  darwin*)
    echo "Detected macOS, generating Brewfile..."
    BREWFILE="${DOTFILES_DIR}/etc/init/macos/Brewfile"
    mkdir -p "$(dirname "$BREWFILE")"
    brew bundle dump --force --file "$BREWFILE"
    echo "Brewfile created at: $BREWFILE"
    ;;
  linux*)
    if grep -q Microsoft /proc/version 2>/dev/null; then
      echo "Detected WSL, generating Brewfile..."
      BREWFILE="${DOTFILES_DIR}/etc/init/wsl/Brewfile"
    else
      echo "Detected Linux, generating Brewfile..."
      BREWFILE="${DOTFILES_DIR}/etc/init/linux/Brewfile"
    fi
    mkdir -p "$(dirname "$BREWFILE")"
    brew bundle dump --force --file "$BREWFILE"
    echo "Brewfile created at: $BREWFILE"
    ;;
  *)
    echo "Unknown OS: ${OSTYPE}, cannot generate Brewfile"
    exit 1
    ;;
esac
