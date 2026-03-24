#!/bin/bash

set -euo pipefail

case "$(uname -s)" in
  Darwin)
    echo "macos"
    ;;
  Linux)
    if [[ -n "${WSL_DISTRO_NAME:-}" || -n "${WSL_INTEROP:-}" ]] \
      || grep -qiE '(microsoft|wsl)' /proc/sys/kernel/osrelease 2>/dev/null \
      || grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null; then
      echo "wsl"
    else
      echo "Unsupported Linux environment. This repo currently supports WSL only." >&2
      exit 1
    fi
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac
