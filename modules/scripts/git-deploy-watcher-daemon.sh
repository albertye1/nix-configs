#!/usr/bin/env bash
# Polls a git checkout for upstream changes and redeploys it with docker compose.
# Invoked by the git-deploy-watcher@.service systemd template; $1 is the directory
# to watch, STATE_DIRECTORY/WATCH_INTERVAL come from the unit's environment.

deploy_path="${1:?usage: git-deploy-watcher-daemon <path>}"
interval="${WATCH_INTERVAL:-120}"
status_file="${STATE_DIRECTORY:-.}/status.json"

write_status() {
  local perms_ok="$1" message="$2" last_update="$3"
  jq -n \
    --arg path "$deploy_path" \
    --arg checked_at "$(date -Iseconds)" \
    --arg last_update "$last_update" \
    --argjson perms_ok "$perms_ok" \
    --arg message "$message" \
    '{path: $path, last_checked: $checked_at, last_update: (if $last_update == "" then null else $last_update end), perms_ok: $perms_ok, message: $message}' \
    >"$status_file.tmp"
  mv "$status_file.tmp" "$status_file"
}

last_update=""

while true; do
  problems=()

  if [ ! -d "$deploy_path" ]; then
    problems+=("directory does not exist: $deploy_path")
  elif ! git -C "$deploy_path" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    problems+=("not a git repository: $deploy_path")
  elif [ ! -w "$deploy_path" ]; then
    problems+=("directory not writable by this user")
  fi

  if [ "${#problems[@]}" -eq 0 ] && ! git -C "$deploy_path" fetch --quiet; then
    problems+=("git fetch failed (check remote/credentials)")
  fi

  if [ "${#problems[@]}" -eq 0 ] && ! docker info >/dev/null 2>&1; then
    problems+=("cannot talk to docker (check group membership)")
  fi

  if [ "${#problems[@]}" -gt 0 ]; then
    message="$(printf '%s; ' "${problems[@]}")"
    write_status false "$message" "$last_update"
  else
    local_rev="$(git -C "$deploy_path" rev-parse HEAD)"
    remote_rev="$(git -C "$deploy_path" rev-parse '@{u}' 2>/dev/null || echo "$local_rev")"

    if [ "$local_rev" != "$remote_rev" ]; then
      if git -C "$deploy_path" pull && (cd "$deploy_path" && docker compose up --build -d); then
        last_update="$(date -Iseconds)"
        write_status true "updated to $remote_rev" "$last_update"
      else
        write_status true "update to $remote_rev failed during pull/redeploy" "$last_update"
      fi
    else
      write_status true "up to date ($local_rev)" "$last_update"
    fi
  fi

  sleep "$interval"
done
