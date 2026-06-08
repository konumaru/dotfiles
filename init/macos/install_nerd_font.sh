#!/bin/bash

set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Run make bootstrap first." >&2
  exit 1
fi

brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
