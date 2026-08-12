#!/usr/bin/env bash
set -Eeuo pipefail

if [[ ! -x node_modules/.bin/reveal-md ]]; then
  echo "reveal-md is not installed; run npm ci first." >&2
  exit 1
fi

npm run build
