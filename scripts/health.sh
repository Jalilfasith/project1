
#!/usr/bin/env bash

set -euo pipefail

log() {
    echo "$(date '+%F %T') $1"
}

check_website() {
    local site="$1"

    if curl -fsS --max-time 5 \
        "http://127.0.0.1:8080/$site/" > /dev/null; then

        log "SUCCESS: Website $site is running"
    else
        log "ERROR: Website $site is not running"
        return 1
    fi
}

mode="${1:-both}"

case "$mode" in
    a)
        check_website a
        ;;
    b)
        check_website b
        ;;
    both)
        for site in a b; do
            check_website "$site"
        done
        ;;
    *)
        echo "Usage: $0 [a|b|both]" >&2
        exit 2
        ;;
esac
