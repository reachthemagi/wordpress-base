# Canonical Skill Sources

## Official WordPress (github.com/WordPress/agent-skills)

Default path: `skills/`

| Skill | Notes |
|-------|-------|
| wordpress-router | Classifies repos and routes to correct workflow |
| wp-project-triage | Detects project type, tooling, versions |
| wp-plugin-development | Architecture, hooks, Settings API, security, packaging |
| wp-block-development | Gutenberg blocks, block.json, deprecations |
| wp-block-themes | theme.json, templates, patterns, FSE |
| wp-rest-api | Routes, schema, auth, response shaping |
| wp-interactivity-api | data-wp-* directives and stores |
| wp-wpcli-and-ops | WP-CLI, search-replace, multisite, automation |
| wp-performance | Caching, profiling, Core Web Vitals |
| wp-abilities-api | Ability registration for agents/MCP |
| wp-playground | Playground CLI, blueprints, testing |
| wp-plugin-directory-guidelines | WordPress.org plugin rules |

## Respira (github.com/respira-press/agent-skills-wordpress)

Default path: `skills/`

| Skill | Notes |
|-------|-------|
| seo-aeo-amplifier | On-page SEO + AEO, schema, Rank Math analysis |
| wordpress-ai-image-optimizer | Compress, WebP, alt text, rename |
| internal-link-builder | Strategic internal linking with safety |
| site-onboarding | First-run discovery and capability mapping |
| wordpress-site-dna | Full site archaeology |
| technical-debt-audit | Orphaned shortcodes, unused plugins, bloat |
| content-portability | Export/import with builder data |
| migrate-elementor-to-gutenberg | and other builder migration skills |

## Additional collections (optional)

- github.com/wpgaurav/WordPress-skills — broader set including marketing and design skills
- github.com/Automattic/wordpress-agent-skills — experimental site-creation skills (older)

## Recommended minimum set for a WordPress development + content agent

1. All core official skills listed above
2. seo-aeo-amplifier
3. wordpress-ai-image-optimizer
4. site-onboarding
5. technical-debt-audit
6. Any Elementor / Rank Math / Yoast specific skills the user requests
