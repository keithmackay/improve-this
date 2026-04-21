# improve-this

## Description

A Claude Code skill that evaluates any project — code, docs, prompts, or otherwise — for potential improvements. Propose which categories to evaluate, review the findings, and optionally generate a phased implementation plan for the issues you care about.

Run it with different AI models (or newly-released models) to surface different improvement perspectives on prior work. The skill is strictly evaluate-and-report — it never modifies files.

## Installation

Copy the skill file to your Claude Code commands directory:

```bash
# Global (available in all projects)
cp improve-this.md ~/.claude/commands/

# Project-specific
cp improve-this.md .claude/commands/
```

## Usage

```
/improve-this                      # Review the full project
/improve-this src/components       # Scope to a directory
/improve-this search               # Scope to a topic
```

The skill will:
1. Infer your project type
2. Propose relevant evaluation categories for you to confirm
3. Analyze the project and present findings with Impact + Confidence ratings
4. Offer to save the report and/or generate an implementation plan for selected findings

**Tip:** Run with different models (`/model` in Claude Code) to get different perspectives on the same codebase.

## License

MIT
