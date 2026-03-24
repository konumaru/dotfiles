#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
PLATFORM="$("${SCRIPT_DIR}/detect_os.sh")"
COMMON_BREWFILE="${DOTFILES_DIR}/init/common/Brewfile"

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

filter_common_entries() {
  local source_file="$1"
  local target_file="$2"
  local exclude_file
  exclude_file="$(mktemp)"

  if [[ -f "${COMMON_BREWFILE}" ]]; then
    grep -vE '^[[:space:]]*(#|$)' "${COMMON_BREWFILE}" > "${exclude_file}" || true
  fi

  printf '%s\n' 'tap "homebrew/bundle"' >> "${exclude_file}"
  grep -Fvx -f "${exclude_file}" "${source_file}" > "${target_file}" || true
  rm -f "${exclude_file}"
}

if ! BREW_BIN="$(resolve_brew)"; then
  echo "Homebrew is not installed." >&2
  exit 1
fi

export HOMEBREW_NO_AUTO_UPDATE=1

TMP_BREWFILE="$(mktemp)"
BREWFILE="${DOTFILES_DIR}/init/${PLATFORM}/Brewfile"
trap 'rm -f "${TMP_BREWFILE}"' EXIT

mkdir -p "$(dirname "${BREWFILE}")"
eval "$("${BREW_BIN}" shellenv)"
"${BREW_BIN}" bundle dump --force --file "${TMP_BREWFILE}"
filter_common_entries "${TMP_BREWFILE}" "${BREWFILE}"

echo "Brewfile created at: ${BREWFILE}"
