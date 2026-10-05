#!/usr/bin/env bash
#
# worktree.sh — shared git-worktree helpers for the start-* scripts.
#
# Source this file, then call the functions below. Every function operates on
# the repository at $REPO_ROOT, which the sourcing script MUST set before use.
#
#   source "$(dirname "${BASH_SOURCE[0]}")/lib/worktree.sh"
#
# Provided functions:
#   resolve_worktree <query>   → prints the uniquely-matching worktree path
#   pick_worktree              → interactive picker, prints the chosen path
#   select_worktree <query>    → convenience: resolve <query> when non-empty,
#                                otherwise fall back to the interactive picker.

# detect_cwd_worktree
# When the current working directory sits inside one of $REPO_ROOT's git
# worktrees, print that worktree's absolute path on stdout and return 0.
# Returns non-zero (printing nothing) when the CWD is outside the repo, is the
# main checkout, or git is unavailable — i.e. when there is no worktree to
# auto-adopt. Never prints diagnostics; callers decide what to say.
detect_cwd_worktree() {
  local cwd_top
  cwd_top="$(git rev-parse --show-toplevel 2>/dev/null)" || return 1

  # Only linked worktrees auto-adopt; the main checkout is not one.
  local repo_top
  repo_top="$(git -C "$REPO_ROOT" rev-parse --show-toplevel 2>/dev/null)" || return 1
  [[ "$cwd_top" == "$repo_top" ]] && return 1

  # Confirm cwd_top is a registered worktree of THIS repo, not an unrelated
  # sibling checkout that merely contains the CWD.
  local line path
  while IFS= read -r line; do
    case "$line" in
    "worktree "*)
      path="${line#worktree }"
      if [[ "$path" == "$cwd_top" ]]; then
        printf '%s\n' "$cwd_top"
        return 0
      fi
      ;;
    esac
  done < <(git -C "$REPO_ROOT" worktree list --porcelain 2>/dev/null)

  return 1
}

# resolve_worktree <query>
# Given a query string, print the matching worktree's absolute path on stdout.
# Matching is: exact path, exact branch, or unique substring of path/branch.
# Exits non-zero (with a message on stderr) when there is no unique match.
resolve_worktree() {
  local query="$1"
  local -a paths=() branches=()
  local path="" branch=""

  # Parse `git worktree list --porcelain` into parallel path/branch arrays.
  while IFS= read -r line; do
    case "$line" in
    "worktree "*)
      path="${line#worktree }"
      ;;
    "branch "*)
      branch="${line#branch refs/heads/}"
      ;;
    "")
      if [[ -n "$path" ]]; then
        paths+=("$path")
        branches+=("$branch")
      fi
      path="" branch=""
      ;;
    esac
  done < <(
    git -C "$REPO_ROOT" worktree list --porcelain
    printf '\n'
  )

  local -a matches=()
  local n=${#paths[@]} i
  for ((i = 0; i < n; i++)); do
    if [[ "${paths[i]}" == "$query" || "${branches[i]}" == "$query" ||
      "${paths[i]}" == *"$query"* || "${branches[i]}" == *"$query"* ]]; then
      matches+=("${paths[i]}")
    fi
  done

  if [[ ${#matches[@]} -eq 0 ]]; then
    echo "Error: no worktree matches '$query'." >&2
    echo "Available worktrees:" >&2
    git -C "$REPO_ROOT" worktree list >&2
    return 1
  fi
  if [[ ${#matches[@]} -gt 1 ]]; then
    echo "Error: '$query' matches multiple worktrees:" >&2
    printf '  %s\n' "${matches[@]}" >&2
    return 1
  fi
  printf '%s\n' "${matches[0]}"
}

# pick_worktree
# Present an interactive picker of all worktrees and print the chosen path.
# Uses fzf when available, otherwise a numbered select menu.
pick_worktree() {
  local -a lines=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && lines+=("$line")
  done < <(git -C "$REPO_ROOT" worktree list)

  if [[ ${#lines[@]} -eq 0 ]]; then
    echo "Error: no worktrees found." >&2
    return 1
  fi

  local chosen=""
  if command -v fzf >/dev/null 2>&1; then
    chosen="$(printf '%s\n' "${lines[@]}" |
      fzf --prompt='worktree> ' --height=40% --reverse --no-multi)" || return 1
  else
    echo "Select a worktree:" >&2
    local PS3="worktree # "
    select chosen in "${lines[@]}"; do
      [[ -n "$chosen" ]] && break
    done
    [[ -z "$chosen" ]] && return 1
  fi

  # Each line starts with the worktree path (whitespace-delimited).
  printf '%s\n' "${chosen%% *}"
}

# select_worktree <query>
# Resolve <query> to a worktree path when non-empty; otherwise present the
# interactive picker. Prints the chosen path on stdout. This is the common
# entry point used by the start-* scripts when --wt is passed.
select_worktree() {
  local query="${1:-}"
  if [[ -n "$query" ]]; then
    resolve_worktree "$query"
  else
    pick_worktree
  fi
}

# Print repo's default branch (origin/HEAD), falling back to main/master.
default_branch() {
  local repo="$1" db
  db="$(git -C "$repo" symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null)" \
    && { printf '%s' "${db#refs/remotes/origin/}"; return 0; }
  for db in main master; do
    if git -C "$repo" show-ref --verify --quiet "refs/remotes/origin/$db"; then
      printf '%s' "$db"; return 0
    fi
  done
  printf 'main'
}

# create_worktree <name>
# Create a fresh branch <name> from the repo's default branch and add a worktree
# for it at $REPO_ROOT/.worktrees/<name>. Prints the new worktree's absolute
# path on stdout; all progress/errors go to stderr. Exits non-zero on failure.
create_worktree() {
  local name="$1"
  local wt_dir="$REPO_ROOT/.worktrees/$name"
  local db

  if [[ -e "$wt_dir" ]]; then
    echo "Error: worktree path already exists: $wt_dir" >&2
    return 1
  fi
  if git -C "$REPO_ROOT" show-ref --verify --quiet "refs/heads/$name"; then
    echo "Error: branch '$name' already exists but has no worktree." >&2
    echo "Remove it or check it out manually, then retry." >&2
    return 1
  fi

  db="$(default_branch "$REPO_ROOT")"
  echo "› Fetching origin/${db}…" >&2
  if ! git -C "$REPO_ROOT" fetch origin "$db" >&2; then
    echo "Error: failed to fetch origin/$db." >&2
    return 1
  fi

  echo "› Creating branch '$name' and worktree at $wt_dir …" >&2
  if ! git -C "$REPO_ROOT" worktree add -b "$name" "$wt_dir" "origin/$db" >&2; then
    echo "Error: failed to create worktree for '$name'." >&2
    return 1
  fi

  copy_env_files "$REPO_ROOT" "$wt_dir"

  printf '%s\n' "$wt_dir"
}

# create_pr_worktree <pr_number> <local_branch> <wt_dir>
# Fetch the head of PR <pr_number> from origin and add a worktree at <wt_dir>
# on a new local branch <local_branch> pointing at that head. Uses the
# refs/pull/<n>/head ref so it works for same-repo and fork PRs alike. Copies
# .env files into the new worktree. Prints the worktree path on stdout; all
# progress/errors go to stderr. Exits non-zero on failure.
create_pr_worktree() {
  local pr_number="$1" branch_name="$2" wt_dir="$3"

  if [[ -e "$wt_dir" ]]; then
    echo "Error: worktree path already exists: $wt_dir" >&2
    return 1
  fi
  if git -C "$REPO_ROOT" show-ref --verify --quiet "refs/heads/$branch_name"; then
    echo "Error: branch '$branch_name' already exists but has no worktree." >&2
    echo "Remove it or check it out manually, then retry." >&2
    return 1
  fi

  echo "› Fetching PR #$pr_number head from origin…" >&2
  if ! git -C "$REPO_ROOT" fetch origin "pull/$pr_number/head" >&2; then
    echo "Error: failed to fetch PR #$pr_number (pull/$pr_number/head)." >&2
    return 1
  fi

  echo "› Creating branch '$branch_name' and worktree at $wt_dir …" >&2
  if ! git -C "$REPO_ROOT" worktree add -b "$branch_name" "$wt_dir" FETCH_HEAD >&2; then
    echo "Error: failed to create worktree for PR #$pr_number." >&2
    return 1
  fi

  copy_env_files "$REPO_ROOT" "$wt_dir"

  printf '%s\n' "$wt_dir"
}

# copy_env_files <src_root> <dst_root>
# Copy every gitignored .env / .env.* file from the source checkout into the
# new worktree at the same relative path, creating parent dirs as needed.
# node_modules and nested .worktrees are skipped so we never pull env files
# from dependencies or from sibling worktrees.
copy_env_files() {
  local src_root="$1" dst_root="$2"
  local count=0 rel dst

  while IFS= read -r -d '' src; do
    rel="${src#"$src_root"/}"
    dst="$dst_root/$rel"
    mkdir -p "$(dirname "$dst")"
    cp -p "$src" "$dst"
    ((count++))
  done < <(
    find "$src_root" \
      \( -name node_modules -o -name .worktrees -o -name .git \) -prune -o \
      -type f \( -name '.npmrc' -o -name '.env' -o -name '.env.*' \) -print0
  )

  if [[ "$count" -gt 0 ]]; then
    echo "› Copied $count .env file(s) into the new worktree." >&2
  fi
}

# Print where a worktree named <name> would live: <repo_root>/.worktrees/<name>.
repo_worktree_path() {
  printf '%s/.worktrees/%s' "$1" "$2"
}

# Return 0 when <repo_root> already has a registered <name> worktree.
repo_has_worktree() {
  local repo="$1" name="$2" want line path
  want="$(repo_worktree_path "$repo" "$name")"
  while IFS= read -r line; do
    case "$line" in
    "worktree "*)
      path="${line#worktree }"
      [[ "$path" == "$want" ]] && return 0
      ;;
    esac
  done < <(git -C "$repo" worktree list --porcelain 2>/dev/null)
  return 1
}

# Create (or adopt) a <name> worktree in <repo_root> off its default branch, copy .env, print its path.
create_worktree_in() {
  local repo="$1" name="$2"
  local wt_dir db
  wt_dir="$(repo_worktree_path "$repo" "$name")"

  if repo_has_worktree "$repo" "$name"; then
    echo "› Reusing existing worktree $wt_dir" >&2
    printf '%s\n' "$wt_dir"
    return 0
  fi
  if [[ -e "$wt_dir" ]]; then
    echo "Error: worktree path already exists but is not registered: $wt_dir" >&2
    return 1
  fi
  if git -C "$repo" show-ref --verify --quiet "refs/heads/$name"; then
    echo "Error: branch '$name' already exists in $(basename "$repo") but has no worktree." >&2
    echo "Remove it or check it out manually, then retry." >&2
    return 1
  fi

  db="$(default_branch "$repo")"
  echo "› [$(basename "$repo")] Fetching origin/${db}…" >&2
  if ! git -C "$repo" fetch origin "$db" >&2; then
    echo "Error: failed to fetch origin/$db for $(basename "$repo")." >&2
    return 1
  fi

  echo "› [$(basename "$repo")] Creating branch '$name' and worktree at $wt_dir …" >&2
  if ! git -C "$repo" worktree add -b "$name" "$wt_dir" "origin/$db" >&2; then
    echo "Error: failed to create worktree for '$name' in $(basename "$repo")." >&2
    return 1
  fi

  copy_env_files "$repo" "$wt_dir"

  printf '%s\n' "$wt_dir"
}

# Remove the <name> worktree from <repo_root>; no-op if absent. Optional third arg: --force.
remove_worktree_in() {
  local repo="$1" name="$2" force="${3:-}"
  local wt_dir
  wt_dir="$(repo_worktree_path "$repo" "$name")"
  repo_has_worktree "$repo" "$name" || return 0
  echo "› [$(basename "$repo")] Removing worktree $wt_dir …" >&2
  git -C "$repo" worktree remove $force "$wt_dir"
}
