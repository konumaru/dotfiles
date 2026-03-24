#!/bin/bash

set -euo pipefail

DOTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

"${DOTPATH}/bin/bootstrap.sh"
make -C "${DOTPATH}" sync
