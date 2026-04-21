# improve-this — Implementation Plan

## Context

This project builds a Claude Code skill called `improve-this`. When invoked, it examines any project (code, docs, prompts, or otherwise) and reports potential improvements across user-selected categories. It is strictly evaluate-and-report — it never modifies files. At the end, the user can optionally save the report and/or generate a phased implementation plan for selected findings.

Designed to be run with different AI models (including newly-released ones) to surface different improvement perspectives on prior work.

---

## Technology Stack

- **Skill format:** Claude Code markdown skill (`.md` file with YAML frontmatter)
- **Installation:** Copy to `~/.claude/commands/` (global) or `.claude/commands/` (project-local)
- **No runtime dependencies** — pure prompt/instruction file

---

## Key Principles

- **YAGNI** — no features beyond what's needed for a useful first review pass
- **DRY** — one skill file is the entire deliverable; no supporting scripts
- **Evaluate only** — the skill must never propose edits to files directly
- **Model-agnostic** — findings reflect the reviewing model's perspective
- **Overwork avoidance** — don't spell out things modern LLMs already do well (see Overwork section)

---

## Phase 1 — Project Setup

### 1.1 Rename project artifacts
- Rename GitHub repo from `new-model-review-skill` to `improve-this`
  - `gh repo rename improve-this --repo keithmackay/new-model-review-skill`
- Update `README.md` title and all references to match

### 1.2 Create the skill file
- **File:** `improve-this.md` at project root
- This is the primary deliverable

### 1.3 Update README
- Description: what the skill does
- Installation: `cp improve-this.md ~/.claude/commands/`
- Usage: `/improve-this [optional path or topic]`
- Tip: run with different models for different perspectives

**Deliverable:** `improve-this.md` exists and README is accurate.

---

## Phase 2 — Skill Design

The skill file follows this structure. Each step is a plain-language instruction to Claude.

### Step 1 — Determine scope
- If user passed an argument (path/topic), scope to that
- Otherwise, full project
- Announce scope

### Step 2 — Explore the project
- Map file structure, read entry points, config, README, test files, manifests
- Infer project type (web app, CLI, API, AI app, library, docs, prompt/skill collection, other)
- Announce inference

### Step 3 — Propose evaluation categories
Tailored to project type. Full candidate list:

*Code projects:* UI/UX, Clarity & Simplification, Code Efficiency, Scalability, Load Performance, Calculation Speed & Accuracy, Search Speed & Accuracy, Test Coverage & Quality, Token Efficiency, Security

*Non-code projects:* Clarity & Simplification, Completeness, Accuracy & Consistency, Navigability & Structure, Redundancy, Edge Case Coverage

Model may add categories appropriate to the specific project. User confirms/adjusts before evaluation begins.

### Step 4 — Evaluate
For each selected category and each finding:
- What was observed
- Why it's a problem or opportunity
- **Impact:** High / Medium / Low
- **Confidence:** High / Medium / Low (net improvement certainty)

No implementation details — "what and why" only.

### Step 5 — Present findings

**Part 1 — Priority List** (sorted by Impact × Confidence):
```
#1  [Impact: High | Confidence: High]   Category — Brief title
#2  [Impact: High | Confidence: Medium] Category — Brief title
```

**Part 2 — Categorized Breakdown:** full details per finding per category.

### Step 6 — Offer next steps
1. Save report? → `docs/reviews/YYYY-MM-DD-improve-this.md`
2. Create implementation plan for selected findings? → `docs/plans/improve-this-YYYY-MM-DD.md`

---

## Phase 3 — Overwork: What to Omit

The skill file should NOT include:
- How to use Glob/Grep/Read — the model knows
- Definitions of High/Medium/Low
- Markdown formatting instructions
- Lists of file extensions to scan
- "Be thorough" / "be concise" filler
- Repeated reminders not to modify files
- Boilerplate about asking clarifying questions

Write the skill like a brief to a senior colleague, not a tutorial.

---

## Phase 4 — Testing (Manual)

No automated tests apply — the deliverable is a prose instruction file.

### 4.1 Code project
- Install skill globally: `cp improve-this.md ~/.claude/commands/`
- Run `/improve-this` from a known code project
- Verify: scope announced → project type inferred → categories proposed → user prompted → findings in both formats → save/plan prompts work

### 4.2 Non-code project
- Run `/improve-this` from a docs or skill project
- Verify: appropriate non-code categories proposed (not Load Performance etc.)

### 4.3 Scoped invocation
- Run `/improve-this src/components` — verify only that subtree examined

### 4.4 Plan generation
- Select a subset of findings → verify a phased plan is produced in `docs/plans/`

### 4.5 Multi-model test
- Switch model (e.g. Sonnet → Opus) and re-run — verify different findings surface

---

## Phase 5 — Release

### 5.1 Commit and push
- `git add improve-this.md README.md docs/`
- `git commit -m "Add improve-this skill"`
- `git push`

---

## Critical Files

| File | Purpose |
|------|---------|
| `improve-this.md` | The skill — primary deliverable |
| `README.md` | Installation and usage docs |

---

## Verification Checklist

- [ ] Skill installed globally and `/improve-this` is invokable
- [ ] Full project review works end-to-end on a code project
- [ ] Non-code project gets appropriate categories
- [ ] Scoped invocation works
- [ ] Save-to-file option works
- [ ] Plan generation works and lands in `docs/plans/`
- [ ] README installation instructions are accurate

---

## Next Steps (Post-Launch)

- [Keith's idea] `--compare` flag to diff findings between two model runs
- [Claude's idea] `docs/reviews/CHANGELOG.md` tracking which findings were acted on across sessions
- [Claude's idea] Companion skill `/improve-this-apply` — takes a saved review and generates the plan non-interactively
- [Claude's idea] `--focus` flag to drill into one category without reproposing all
- [Keith's idea] Review a specific git branch or commit range (only what changed)
