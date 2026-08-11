---
name: wordpress-skills-cloner
description: Clone and install curated WordPress AI agent skills into a repository under .github/skills. Use when the user asks to set up WordPress skills in a repo, clone official or community WordPress agent skills, populate .github/skills, or bootstrap a project with WordPress development, SEO, Elementor, Rank Math, Yoast, security, PHP, JS, or performance skills.
---

# WordPress Skills Cloner

Clone the recommended official and community WordPress AI agent skills into the current repository at `.github/skills/`.

## Target layout

Create or update this structure in the repo root:

```
.github/
└── skills/
    ├── README.md                  # Index of installed skills
    ├── wordpress-router/
    ├── wp-project-triage/
    ├── wp-plugin-development/
    ├── wp-block-development/
    ├── wp-block-themes/
    ├── wp-rest-api/
    ├── wp-interactivity-api/
    ├── wp-wpcli-and-ops/
    ├── wp-performance/
    ├── wp-abilities-api/
    ├── wp-playground/
    ├── seo-aeo-amplifier/
    ├── wordpress-ai-image-optimizer/
    ├── internal-link-builder/
    ├── site-onboarding/
    ├── wordpress-site-dna/
    ├── technical-debt-audit/
    └── ... (additional migration / content skills as requested)
```

## Primary sources

1. **Official WordPress skills** (highest priority foundation)
   - Repo: `https://github.com/WordPress/agent-skills`
   - Path inside repo: `skills/`
   - Key skills to include by default:
     - wordpress-router
     - wp-project-triage
     - wp-plugin-development
     - wp-block-development
     - wp-block-themes
     - wp-rest-api
     - wp-interactivity-api
     - wp-wpcli-and-ops
     - wp-performance
     - wp-abilities-api (and related audit/verify if present)
     - wp-playground
     - wp-plugin-directory-guidelines (optional)

2. **Respira community skills** (site ops, SEO, Elementor migrations, audits)
   - Repo: `https://github.com/respira-press/agent-skills-wordpress`
   - Path inside repo: `skills/`
   - Recommended defaults:
     - seo-aeo-amplifier
     - wordpress-ai-image-optimizer
     - internal-link-builder
     - site-onboarding
     - wordpress-site-dna
     - technical-debt-audit
     - content-portability
     - Any Elementor migration skills the user requests (migrate-elementor-to-gutenberg, etc.)

3. Optional community collections (only if user asks)
   - `https://github.com/wpgaurav/WordPress-skills` (broader marketing/SEO set)

## Procedure

### 1. Prepare the destination

```bash
mkdir -p .github/skills
```

If `.github/skills` already exists, list its contents and ask the user whether to overwrite, merge, or skip existing skill folders.

### 2. Clone official WordPress skills (sparse / selective)

Preferred method (avoids cloning the entire history):

```bash
# Temporary workspace
TMP=$(mktemp -d)
git clone --depth 1 --filter=blob:none --sparse https://github.com/WordPress/agent-skills.git "$TMP/wp-skills"
cd "$TMP/wp-skills"
git sparse-checkout set skills
```

Then copy the desired skill directories:

```bash
for skill in wordpress-router wp-project-triage wp-plugin-development wp-block-development wp-block-themes wp-rest-api wp-interactivity-api wp-wpcli-and-ops wp-performance wp-abilities-api wp-playground; do
  if [ -d "skills/$skill" ]; then
    cp -a "skills/$skill" "$OLDPWD/.github/skills/"
  fi
done
```

Clean up the temporary clone afterward.

Fallback if sparse-checkout is unavailable: full shallow clone then selective copy.

### 3. Clone Respira skills

```bash
TMP2=$(mktemp -d)
git clone --depth 1 --filter=blob:none --sparse https://github.com/respira-press/agent-skills-wordpress.git "$TMP2/respira"
cd "$TMP2/respira"
git sparse-checkout set skills
```

Copy the recommended set:

```bash
for skill in seo-aeo-amplifier wordpress-ai-image-optimizer internal-link-builder site-onboarding wordpress-site-dna technical-debt-audit content-portability; do
  if [ -d "skills/$skill" ]; then
    cp -a "skills/$skill" "$OLDPWD/.github/skills/"
  fi
done
```

Add any migration skills the user explicitly requests (e.g. `migrate-elementor-to-gutenberg`).

### 4. Create an index README

Write `.github/skills/README.md` that lists every installed skill with a one-line description and source attribution. Keep it short.

Example structure:

```markdown
# WordPress Agent Skills

Installed for AI coding agents (Claude Code, Cursor, Codex, etc.).

## Official (WordPress/agent-skills)
- wp-plugin-development — Plugin architecture, hooks, security
- ...

## Community (Respira)
- seo-aeo-amplifier — On-page SEO + AEO with Rank Math awareness
- ...
```

### 5. Optional post-steps

- If the repo uses Claude Code / Cursor conventions, ensure skills are discoverable (some agents also look in `.claude/skills` or `.cursor/skills`). Offer to symlink or copy if the user wants dual locations.
- Remind the user to commit the new `.github/skills` directory.
- Tell the user to restart their agent session or reload skills so the new folders are picked up.

## Safety and constraints

- Never overwrite an existing skill folder without explicit user confirmation.
- Prefer shallow + sparse clones to keep the operation fast and lightweight.
- Do not commit secrets or tokens.
- If network access is blocked, fall back to documenting the exact git commands the user can run manually.
- Validate each copied directory contains a `SKILL.md` before considering it installed.

## Custom / additional skills

If the user wants skills that do not exist upstream (Elementor page builder deep skill, Rank Math specific skill, Yoast specific skill, general WordPress security hardening skill, pure PHP/JS WordPress coding standards skill, etc.), create them locally under `.github/skills/<name>/` using the skill-creator pattern rather than inventing content from thin air. Point the user to the skill-creator skill for authoring.

## References

See `references/sources.md` for the canonical list of recommended skills and their upstream paths.
