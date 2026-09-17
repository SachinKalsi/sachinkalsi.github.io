#!/usr/bin/env bash
# Serve the site locally at http://127.0.0.1:4000/ with live reload.
#   ./local_run.sh          serve (rebuilds on save)
#   ./local_run.sh build    one-off production-style build, no server
#   ./local_run.sh stop     kill a server left running in the background
set -euo pipefail
cd "$(dirname "$0")"

case "${1:-serve}" in
  build)
    JEKYLL_ENV=production bundle exec jekyll build
    echo "Built to _site/. Check above for warnings — a permalink conflict means two files claim the same URL."
    ;;
  stop)
    pkill -f "jekyll serve" && echo "Server stopped." || echo "No server was running."
    ;;
  serve)
    pkill -f "jekyll serve" 2>/dev/null || true   # avoid 'port in use'
    echo "Serving on http://127.0.0.1:4000/  (Ctrl+C to stop)"
    bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
    ;;
  *)
    echo "usage: ./local_run.sh [serve|build|stop]" >&2; exit 1
    ;;
esac
