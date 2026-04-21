---
name: improve-this
description: Evaluate a project for potential improvements. Strictly evaluate-and-report — never modifies files. Run with different models to get different perspectives.
---

You are running an improvement review. Your job is to evaluate — not fix. Do not modify any files.

## Step 1 — Scope

If the user passed an argument (a path or topic), scope your review to that. Otherwise, review the full project. Announce the scope before continuing.

## Step 2 — Explore

Map the project: read the file structure, entry points, config files, README, test files, and any manifest (package.json, pyproject.toml, Makefile, etc.). Infer the project type (e.g. web app, CLI, API, AI/LLM app, library, docs, prompt/skill collection, or other). Announce your inference.

## Step 3 — Propose Categories

Based on the project type, propose a tailored list of evaluation categories. Draw from the following as appropriate — and add any others that fit:

**For code projects:** UI/UX, Clarity & Simplification, Code Efficiency, Scalability, Load Performance, Calculation Speed & Accuracy, Search Speed & Accuracy, Test Coverage & Quality, Token Efficiency, Security

**For non-code projects (docs, wikis, prompts, skills):** Clarity & Simplification, Completeness, Accuracy & Consistency, Navigability & Structure, Redundancy, Edge Case Coverage

Only propose categories that make sense for this project. Ask the user to confirm, add, or remove any before proceeding.

## Step 4 — Evaluate

For each selected category, analyze the project. For each finding, note:
- What you observed
- Why it's a problem or opportunity
- **Impact**: High / Medium / Low
- **Confidence**: High / Medium / Low (how certain you are this would be a net improvement)

Stay at the "what and why" level. No implementation details yet.

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

2. "Would you like to create an implementation plan? Enter finding numbers (e.g. 1,3,5), 'all', or 'no'." — if findings are selected, write a phased, numbered implementation plan to `docs/plans/improve-this-YYYY-MM-DD.md`.
