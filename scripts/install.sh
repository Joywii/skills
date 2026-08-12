#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_root="$repo_root/skills"
target="$HOME/.codex/skills"
requested_skill=""

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [--target PATH] [--skill SLUG]

Installs repository Skills into a flat host directory. Existing Skill
directories are never overwritten.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || { echo "--target requires a path" >&2; exit 2; }
      target="$2"
      shift 2
      ;;
    --skill)
      [[ $# -ge 2 ]] || { echo "--skill requires a slug" >&2; exit 2; }
      requested_skill="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

mkdir -p "$target"
found=0
installed=0

while IFS= read -r skill_file; do
  skill_dir="$(dirname "$skill_file")"
  slug="$(basename "$skill_dir")"

  if [[ -n "$requested_skill" && "$slug" != "$requested_skill" ]]; then
    continue
  fi

  found=$((found + 1))
  destination="$target/$slug"
  if [[ -e "$destination" ]]; then
    echo "Refusing to overwrite existing Skill: $destination" >&2
    exit 1
  fi

  cp -R "$skill_dir" "$destination"
  installed=$((installed + 1))
  echo "Installed $slug -> $destination"
done < <(find "$skills_root" -type f -name SKILL.md | sort)

if [[ $found -eq 0 ]]; then
  if [[ -n "$requested_skill" ]]; then
    echo "Skill not found: $requested_skill" >&2
  else
    echo "No Skills found under $skills_root" >&2
  fi
  exit 1
fi

echo "Installed $installed Skill(s)."
