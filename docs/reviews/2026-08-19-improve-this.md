# improve-this — Review (2026-08-19)

**Scope:** Full project
**Project type:** Prompt/skill collection — multi-platform Claude Code / Codex / Antigravity / Gemini CLI skill distribution
**Categories evaluated:** Clarity & Simplification, Accuracy & Consistency, Navigability & Structure, Redundancy, Token Efficiency & Progressive Disclosure, Completeness

## Priority List

```
#1  [Impact: High   | Confidence: High]   Accuracy & Consistency — TESTING_GUIDELINES.md is a leftover from an unrelated project (HabitPeeps/Flutter)
#2  [Impact: Medium | Confidence: High]   Redundancy — skill body is duplicated across 3 files with no single source of truth
#3  [Impact: Low    | Confidence: Medium] Navigability & Structure — docs/specs/ is an empty, purposeless directory
#4  [Impact: Low    | Confidence: Medium] Completeness — AGENTS.md is a near-empty stub with no actual Codex-facing content
#5  [Impact: Low    | Confidence: Low]    Token Efficiency & Progressive Disclosure — no further extraction candidates found; pattern already applied well
```

## Categorized Breakdown

### Accuracy & Consistency

**`docs/TESTING_GUIDELINES.md` describes a different, unrelated project.** The file is titled "HabitPeeps Testing Guidelines," covers Flutter/Dart testing (`flutter test`, `pubspec`, widget tests, `test/unit/`, `test/widget/`), and was committed in the very first commit ("Initial project setup with README") — evidently copied wholesale from a template or another repo and never adapted. `improve-this` is a pure markdown instruction file with no code, no test suite, no Flutter dependency at all. Anyone landing on this repo (it's public per the README's install instructions) sees testing documentation that has nothing to do with the project.

- **Impact:** High — visible, actively misleading, undermines credibility of a project whose whole pitch is careful review of other projects.
- **Confidence:** High — unambiguously wrong, not a judgment call.

### Redundancy

**The skill body exists as 3 separate, hand-synced copies**: `SKILL.md` (Antigravity), `improve-this.md` (Claude Code direct command), `skills/improve-this/SKILL.md` (Claude Code plugin / Codex, via `.codex-plugin/plugin.json`). `GEMINI.md` avoids this by using an `@./skills/improve-this/SKILL.md` include instead of copy-pasting. This is a demonstrated risk, not theoretical — earlier this session `improve-this.md` drifted out of sync with the other two copies (missing the `--help` flag section and the progressive-disclosure category) and had to be manually reconciled. There's no CI check or generation step enforcing the three stay identical.

- **Impact:** Medium — each drift is a silent behavior difference between platforms, not a crash.
- **Confidence:** High — the failure mode already happened once.

### Navigability & Structure

**`docs/specs/` is empty.** No files, and (since git doesn't track empty directories) it isn't even part of the actual git history — it's local-only cruft that will confuse anyone browsing the checkout, implying there should be spec docs that don't exist.

- **Impact:** Low
- **Confidence:** Medium — could be intentional scaffolding for future use, but nothing references it.

### Completeness

**`AGENTS.md` is two lines: a header and nothing else.** Codex's actual routing is via `.codex-plugin/plugin.json` → `skills/`, so this file may not be load-bearing for Codex today, but its presence with no content reads as an unfinished port compared to the fully fleshed-out `GEMINI.md`. Either it should carry real Codex-facing guidance or be removed to avoid implying there's Codex-specific documentation that doesn't exist.

- **Impact:** Low
- **Confidence:** Medium — depends on whether Codex's AGENTS.md convention expects content here; worth a quick check of Codex's docs before treating this as a real gap.

### Token Efficiency & Progressive Disclosure

No new findings — `help.md` is already externalized and loaded only via `--help`, and the remaining always-loaded skill body (Steps 1–6) is procedural instruction with no bulky reference material left to extract. This confirms the earlier fix worked as intended.

### Clarity & Simplification

No findings — the skill body reads tightly, no filler.
