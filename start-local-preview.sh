#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
cd "$(dirname "$0")"

bundle exec jekyll serve --host 0.0.0.0 --port 4000
