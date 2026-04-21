# improve-this — Phases Summary

Quick-reference overview of the implementation roadmap.

---

## Technology Stack

- Claude Code markdown skill (`.md` + YAML frontmatter)
- No runtime dependencies — pure instruction file
- Install via `cp improve-this.md ~/.claude/commands/`

---

## Key Principles

| Principle | Application |
|-----------|------------|
| YAGNI | One skill file, no supporting scripts |
| DRY | Single source of truth for all review logic |
| Evaluate only | Skill never modifies files |
| Model-agnostic | Findings reflect the reviewing model's perspective |
| No overwork | Don't spell out what modern LLMs already do well |

---

## Phase 1 — Project Setup

**Goal:** Rename project artifacts and create the skill file.

Tasks:
1. Rename GitHub repo to `improve-this`
2. Create `improve-this.md` at project root
3. Update `README.md` with accurate description, installation, and usage

**Deliverable:** Skill file exists, README is accurate, repo is named correctly.

---

## Phase 2 — Skill Design

**Goal:** Write the skill file following a 6-step evaluation flow.

Tasks:
1. Scope determination (full project or user-specified path/topic)
2. Project exploration and type inference
3. Category proposal tailored to project type (user confirms)
4. Per-category evaluation with Impact + Confidence ratings
5. Dual-format output: priority list + categorized breakdown
6. Next-steps prompts: save report? generate plan?

**Deliverable:** `improve-this.md` implements full evaluation flow.

---

## Phase 3 — Overwork Avoidance

**Goal:** Ensure skill file is lean — omit instructions the model doesn't need.

Tasks:
1. Remove any how-to-use-tools instructions
2. Remove definitions of self-evident terms
3. Remove repeated reminders or filler phrases

**Deliverable:** Skill reads like a brief to a senior colleague, not a tutorial.

---

## Phase 4 — Testing

**Goal:** Verify skill works across project types and invocation modes.

Tasks:
1. Test on a code project (full sweep)
2. Test on a non-code project (docs/skills — appropriate categories)
3. Test scoped invocation (`/improve-this src/`)
4. Test plan generation for selected findings
5. Test with multiple models to confirm different perspectives surface

**Deliverable:** All manual test cases pass.

---

## Phase 5 — Release

**Goal:** Commit, push, and make skill available.

Tasks:
1. Commit all files with message "Add improve-this skill"
2. Push to `origin/main`

**Deliverable:** Skill live in repo, installable from README instructions.

---

## Success Criteria

- `/improve-this` runs end-to-end on any project type
- Categories adapt to what's being reviewed (code vs. non-code)
- Findings are prioritized by Impact × Confidence
- User controls scope, categories, saving, and planning
- Different models produce meaningfully different findings

---

## Post-Launch Maintenance

- Skill files are stateless — no maintenance needed unless Claude Code skill format changes
- Add new default categories as new project types emerge
- See "Next Steps" in `implementation-plan.md` for enhancement ideas
