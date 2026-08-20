# improve-this — Implementation Plan (2026-08-19)

Source review: `docs/reviews/2026-08-19-improve-this.md`. All 5 findings selected; #5 (Token Efficiency & Progressive Disclosure) had no actionable finding, so no phase is needed for it.

## Phase 1 — Remove leftover HabitPeeps testing docs

**Finding:** `docs/TESTING_GUIDELINES.md` is a Flutter/Dart testing guide for an unrelated project ("HabitPeeps"), copied in wholesale in the initial commit and never adapted or referenced by anything in `improve-this`.

Tasks:
1. Confirm nothing in this repo links to or depends on `docs/TESTING_GUIDELINES.md` (README, SKILL.md, help.md, plans).
2. Delete `docs/TESTING_GUIDELINES.md`.
3. Since `improve-this` is a prose instruction file with no automated test suite, do not replace it with a new testing doc — the manual test cases already listed in `docs/plans/implementation-plan.md` Phase 4 are sufficient. If that coverage feels thin, note it as a follow-up rather than reintroducing template boilerplate.

**Deliverable:** No unrelated-project content remains in the repo.

## Phase 2 — Single source of truth for the skill body

**Finding:** `SKILL.md`, `improve-this.md`, and `skills/improve-this/SKILL.md` are three hand-maintained copies of the same instruction content. They already drifted out of sync once this session and had to be manually reconciled. `GEMINI.md` avoids the problem entirely by using an `@./skills/improve-this/SKILL.md` include.

Tasks:
1. Pick one file as canonical — `skills/improve-this/SKILL.md` is the natural choice since it's what `.codex-plugin/plugin.json` and the Claude Code plugin path both already point to.
2. Replace `SKILL.md` and `improve-this.md` with either:
   - a platform-native include/reference to the canonical file (matching the `GEMINI.md` pattern), if the target platform (Antigravity, Claude Code direct command) supports file includes, or
   - if includes aren't supported on a given platform, leave the duplication but add a checked-in note at the top of each duplicate ("this file must be kept identical to skills/improve-this/SKILL.md") and consider a lightweight sync check.
3. Verify install instructions in `README.md` still match wherever files ended up after this change.

**Deliverable:** Only one file contains the actual instruction text; other platform entry points reference it rather than duplicating it, or are clearly marked as synced copies with an enforcement mechanism.

## Phase 3 — Remove the empty docs/specs/ directory

**Finding:** `docs/specs/` is empty, untracked by git, and not referenced anywhere.

Tasks:
1. Delete the empty `docs/specs/` directory.

**Deliverable:** No purposeless directories in the checkout.

## Phase 4 — Resolve the AGENTS.md stub

**Finding:** `AGENTS.md` is two lines (a header, nothing else), while Codex actually reads `.codex-plugin/plugin.json` → `skills/`. Unclear whether AGENTS.md is expected to carry real content by Codex convention.

Tasks:
1. Check Codex's AGENTS.md convention (referenced in README's "References" section: https://developers.openai.com/codex/plugins/build) to determine whether AGENTS.md is expected to contain project-facing content, or whether it's redundant with `.codex-plugin/plugin.json`.
2. If content is expected: add real Codex-facing guidance, following the density/no-filler style established in `skills/improve-this/SKILL.md`.
3. If not expected: delete `AGENTS.md` to avoid implying an unfinished Codex port.

**Deliverable:** `AGENTS.md` either has real content or doesn't exist — no empty stub.

## Verification Checklist

- [ ] `docs/TESTING_GUIDELINES.md` removed, nothing references it
- [ ] Skill body has one canonical source; other entry points reference or are clearly marked as synced copies
- [ ] `docs/specs/` removed
- [ ] `AGENTS.md` resolved (filled in or removed) per Codex convention
- [ ] `README.md` install instructions still accurate after any file moves
