#!/usr/bin/env bash
# User-facing control for git-deploy-watcher@.service instances. Each watched
# directory maps to one template instance, named via systemd-escape --path.
set -euo pipefail

usage() {
  echo "usage: git-deploy-watcher-ctl <start|stop|restart> <directory>" >&2
  echo "       git-deploy-watcher-ctl status [directory]" >&2
  exit 1
}

unit_for() {
  echo "git-deploy-watcher@$(systemd-escape --path "$(realpath "$1")").service"
}

[ "$#" -ge 1 ] || usage
cmd="$1"
shift

case "$cmd" in
  start | stop | restart)
    [ "$#" -eq 1 ] || usage
    exec systemctl "$cmd" "$(unit_for "$1")"
    ;;
  status)
    if [ "$#" -eq 1 ]; then
      dir="$(realpath "$1")"
      instance="$(systemd-escape --path "$dir")"
      unit="git-deploy-watcher@$instance.service"
      echo "== $unit =="
      systemctl status "$unit" --no-pager || true
      status_file="/var/lib/git-deploy-watcher/$instance/status.json"
      if [ -f "$status_file" ]; then
        echo
        echo "== watcher status =="
        jq . "$status_file"
      else
        echo
        echo "no status file yet at $status_file"
      fi
    else
      shopt -s nullglob
      dirs=(/var/lib/git-deploy-watcher/*/)
      if [ "${#dirs[@]}" -eq 0 ]; then
        echo "no git-deploy-watcher instances have reported status yet"
      fi
      for d in "${dirs[@]}"; do
        [ -f "$d/status.json" ] || continue
        echo "--- ${d%/} ---"
        jq . "$d/status.json"
      done
    fi
    ;;
  *)
    usage
    ;;
esac
