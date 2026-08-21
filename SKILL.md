---
name: improve-this
description: Evaluate a project for potential improvements. Strictly evaluate-and-report — never modifies files. Run with different models to get different perspectives.
---

<!-- SYNC: synced copy of skills/improve-this/SKILL.md. Edit that file, not this one. Run scripts/check-sync.sh after editing. -->

You are running an improvement review. Your job is to evaluate — not fix. Do not modify any files.

## Flags

### `--help`

If the user invokes this skill with a `--help` flag (e.g. `/improve-this --help`), do not run the review. Instead, read and display the contents of `help.md` (in this skill's folder) verbatim, then stop.

### `--version`

If the user invokes this skill with a `--version` flag (e.g. `/improve-this --version`), do not run the workflow. Instead:

1. Read the installed version from this skill's own manifest: `.claude-plugin/plugin.json` if present, else `.codex-plugin/plugin.json`, else `gemini-extension.json` — whichever exists for this platform install. If none exist (a bare Claude Code skill with only SKILL.md), read the topmost version heading in `CHANGELOG.md` instead.
2. Print: `improve-this v<installed-version>`
3. Best-effort update check — determine this skill's GitHub source repo:
   a. If `.git` exists here and `git remote get-url origin` resolves to a `github.com` URL, use that `owner/repo`.
   b. Otherwise, search this skill's own `README.md` for the first `https://github.com/<owner>/<repo>` URL and use that.
   c. If neither yields a repo, or the `gh` CLI isn't installed/authenticated: stop here. Print nothing further — no status line, no error.
4. If a repo was found: run `gh api repos/<owner>/<repo>/releases/latest -q .tag_name` (strip a leading `v`). Compare to the installed version:
   - Equal → append: `Status: up to date`
   - Installed is older → append: `Status: newer version available (v<latest>). To update: if you installed this via a Claude Code marketplace, run /plugin marketplace update <marketplace-name> then reinstall; otherwise, git pull in your install directory if it's a git checkout, or re-copy from https://github.com/<owner>/<repo> per this README's Installation section.`
   - Installed is newer → append: `Status: ahead of latest release (development checkout)`
   - If the API call fails for any reason (network, auth, rate limit, malformed tag): print nothing further — no status line, no error shown to the user.
5. Stop — do not proceed to run the skill's actual workflow.

## Step 1 — Scope

If the user passed an argument (a path or topic), scope your review to that. Otherwise, review the full project. Announce the scope before continuing.

## Step 2 — Explore

Map the project: read the file structure, entry points, config files, README, test files, and any manifest (package.json, pyproject.toml, Makefile, etc.). Infer the project type (e.g. web app, CLI, API, AI/LLM app, library, docs, prompt/skill collection, or other). Announce your inference.

## Step 3 — Propose Categories

Based on the project type, propose a tailored list of evaluation categories. Draw from the following as appropriate — and add any others that fit:

**For code projects:** UI/UX, Clarity & Simplification, Code Efficiency, Scalability, Load Performance, Calculation Speed & Accuracy, Search Speed & Accuracy, Test Coverage & Quality, Token Efficiency, Security

**For non-code projects (docs, wikis, prompts, skills):** Clarity & Simplification, Completeness, Accuracy & Consistency, Navigability & Structure, Redundancy, Edge Case Coverage

**For Claude Code skills/commands specifically, also propose:** Token Efficiency & Progressive Disclosure — does the always-loaded file (SKILL.md/command file) contain content that isn't needed on every invocation (setup/usage instructions, exhaustive templates, rarely-needed reference material)? Content only needed situationally should live in a separate file (e.g. a README.md for setup/usage, or a `references/` file for templates/lookups) and be pulled in on demand rather than loaded every time the skill fires.

Only propose categories that make sense for this project. Ask the user to confirm, add, or remove any before proceeding.

## Step 4 — Evaluate

For each selected category, analyze the project. For each finding, note:
- What you observed
- Why it's a problem or opportunity
- **Impact**: High / Medium / Low
- **Confidence**: High / Medium / Low (how certain you are this would be a net improvement)

Stay at the "what and why" level. No implementation details yet.

For Token Efficiency & Progressive Disclosure findings on a skill/command project, name specifically which content should move out (e.g. "usage/setup instructions → README.md, referenced only when the user asks how to install or configure") and note that a Clarity & Simplification pass on the remaining always-loaded content is also worth doing.

## Step 5 — Present Findings

**Part 1 — Priority List** (sorted by Impact × Confidence, highest first):
```
#1  [Impact: High | Confidence: High]   Category — Brief title
#2  [Impact: High | Confidence: Medium] Category — Brief title
...
```

**Part 2 — Categorized Breakdown**
One section per category with full finding details.

## Step 6 — Next Steps

Ask the user:

1. "Would you like to save this report? (Y/N)" — if yes, save to `docs/reviews/YYYY-MM-DD-improve-this.md` in the current project.

2. "Would you like to create an implementation plan? Enter finding numbers (e.g. 1,3,5), 'all', or 'no'." — if findings are selected, write a phased, numbered implementation plan to `docs/plans/improve-this-YYYY-MM-DD.md`. When a selected finding is a Token Efficiency & Progressive Disclosure or Clarity & Simplification finding on a skill/command project, have the plan call out using the `/readme` skill to generate/extract the README and the `/plsfix` skill to do the clarity/token-efficiency pass on the remaining skill docs, rather than describing that work from scratch.
