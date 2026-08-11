#!/usr/bin/env bash
# Clone curated WordPress agent skills into .github/skills of the current repo.
# Usage: bash clone-wordpress-skills.sh [--official-only] [--respira-only] [--force]
set -euo pipefail

FORCE=0
OFFICIAL=1
RESPIRA=1

for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --official-only) RESPIRA=0 ;;
    --respira-only) OFFICIAL=0 ;;
  esac
done

REPO_ROOT="$(pwd)"
DEST="${REPO_ROOT}/.github/skills"
mkdir -p "$DEST"

copy_skill() {
  local src="$1"
  local name
  name="$(basename "$src")"
  local target="${DEST}/${name}"

  if [[ -d "$target" && $FORCE -eq 0 ]]; then
    echo "SKIP (exists): $name  (use --force to overwrite)"
    return
  fi

  if [[ ! -f "${src}/SKILL.md" ]]; then
    echo "WARN: no SKILL.md in $src — skipping"
    return
  fi

  rm -rf "$target"
  cp -a "$src" "$target"
  echo "INSTALLED: $name"
}

# --- Official WordPress skills ---
if [[ $OFFICIAL -eq 1 ]]; then
  echo "=== Cloning official WordPress/agent-skills ==="
  TMP=$(mktemp -d)
  git clone --depth 1 --filter=blob:none --sparse \
    https://github.com/WordPress/agent-skills.git "$TMP/wp" 2>/dev/null || {
      echo "ERROR: failed to clone WordPress/agent-skills"
      exit 1
    }
  (
    cd "$TMP/wp"
    git sparse-checkout set skills
  )

  OFFICIAL_SKILLS=(
    wordpress-router
    wp-project-triage
    wp-plugin-development
    wp-block-development
    wp-block-themes
    wp-rest-api
    wp-interactivity-api
    wp-wpcli-and-ops
    wp-performance
    wp-abilities-api
    wp-playground
    wp-plugin-directory-guidelines
  )

  for s in "${OFFICIAL_SKILLS[@]}"; do
    if [[ -d "$TMP/wp/skills/$s" ]]; then
      copy_skill "$TMP/wp/skills/$s"
    else
      echo "NOTE: $s not found in official repo (may have been renamed)"
    fi
  done
  rm -rf "$TMP"
fi

# --- Respira skills ---
if [[ $RESPIRA -eq 1 ]]; then
  echo "=== Cloning respira-press/agent-skills-wordpress ==="
  TMP=$(mktemp -d)
  git clone --depth 1 --filter=blob:none --sparse \
    https://github.com/respira-press/agent-skills-wordpress.git "$TMP/respira" 2>/dev/null || {
      echo "ERROR: failed to clone respira-press/agent-skills-wordpress"
      exit 1
    }
  (
    cd "$TMP/respira"
    git sparse-checkout set skills
  )

  RESPIRA_SKILLS=(
    seo-aeo-amplifier
    wordpress-ai-image-optimizer
    internal-link-builder
    site-onboarding
    wordpress-site-dna
    technical-debt-audit
    content-portability
  )

  for s in "${RESPIRA_SKILLS[@]}"; do
    if [[ -d "$TMP/respira/skills/$s" ]]; then
      copy_skill "$TMP/respira/skills/$s"
    else
      echo "NOTE: $s not found in Respira repo"
    fi
  done
  rm -rf "$TMP"
fi

echo ""
echo "Done. Skills are in: $DEST"
echo "Commit the .github/skills directory and restart your agent session to load them."
