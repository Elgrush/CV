#!/usr/bin/env bash

set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$project_dir"

exec nix develop --command latexmk \
  -xelatex \
  -g \
  -halt-on-error \
  -interaction=nonstopmode \
  -file-line-error \
  cv-llt.tex
