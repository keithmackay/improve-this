# improve-this

## Description

A skill that evaluates any project — code, docs, prompts, or otherwise — for potential improvements. Propose which categories to evaluate, review the findings, and optionally generate a phased implementation plan for the issues you care about.

Run it with different AI models (or newly-released models) to surface different improvement perspectives on prior work. The skill is strictly evaluate-and-report — it never modifies files.

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

**Tip:** Run with different models to get different perspectives on the same codebase.

## Installation

### Claude Code

```bash
# Global (available in all projects)
cp SKILL.md ~/.claude/skills/improve-this/SKILL.md

# Or symlink the whole directory
ln -s /path/to/improve-this/ ~/.claude/skills/improve-this
```

Then invoke with: `/improve-this`

### Codex

Add to your marketplace JSON (`~/.agents/plugins/marketplace.json`, create if absent):

```json
{
  "name": "personal",
  "interface": { "displayName": "Personal Plugins" },
  "plugins": [
    {
      "name": "improve-this",
      "source": { "source": "local", "path": "/path/to/improve-this/" },
      "policy": { "installation": "AVAILABLE", "authentication": "ON_INSTALL" },
      "category": "Productivity"
    }
  ]
}
```

### Antigravity

The root `SKILL.md` is fully Antigravity-compatible (no platform-specific metadata to strip).

```bash
# Global install (all workspaces)
cp -r /path/to/improve-this/ ~/.gemini/antigravity/skills/improve-this/

# Workspace install (current project only)
cp -r /path/to/improve-this/ .agents/skills/improve-this/
```

Skills are auto-discovered. Mention `/improve-this` to activate.

### Gemini CLI

```bash
gemini extensions install https://github.com/keithmackay/improve-this
```

To update:
```bash
gemini extensions update improve-this
```

The skill is auto-discovered from `GEMINI.md` after installation.

## Compatibility

| Feature | Claude Code | Codex | Antigravity | Gemini CLI |
|---------|:-----------:|:-----:|:-----------:|:----------:|
| Core skill | ✅ | ✅ | ✅ | ✅ |
| Subagent dispatch | ✅ | ✅ | ✅ | ❌ |

Legend: ✅ Supported · ❌ Not supported

> **Gemini CLI note:** This skill does not use subagent dispatch, so full functionality is available on all platforms.

## License

MIT

## References

- **Claude Code Skills:** https://code.claude.com/docs/en/skills
- **Claude Code Complete Guide (PDF):** https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf
- **Codex Plugins:** https://developers.openai.com/codex/plugins/build
- **Antigravity Skills:** https://antigravity.google/docs/skills
- **Gemini CLI Extensions:** https://github.com/google-gemini/gemini-cli/blob/main/docs/extension.md
- **Agent Skills open standard:** https://agentskills.io/home
