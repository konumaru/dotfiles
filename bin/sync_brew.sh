#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
PLATFORM="$("${SCRIPT_DIR}/detect_os.sh")"
COMMON_BREWFILE="${DOTFILES_DIR}/init/common/Brewfile"
PLATFORM_BREWFILE="${DOTFILES_DIR}/init/${PLATFORM}/Brewfile"

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

if ! BREW_BIN="$(resolve_brew)"; then
  echo "Homebrew is not installed. Run 'make bootstrap' first." >&2
  exit 1
fi

export HOMEBREW_NO_AUTO_UPDATE=1

eval "$("${BREW_BIN}" shellenv)"

if [[ -f "${COMMON_BREWFILE}" ]]; then
  "${BREW_BIN}" bundle --file="${COMMON_BREWFILE}" --no-upgrade
fi

if [[ -f "${PLATFORM_BREWFILE}" ]]; then
  "${BREW_BIN}" bundle --file="${PLATFORM_BREWFILE}" --no-upgrade
else
  echo "Brewfile not found: ${PLATFORM_BREWFILE}" >&2
  exit 1
fi
