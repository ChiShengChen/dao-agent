# Daoist Talismans ── Claude Code Agent Prompt Generator

> [中文](README.md)

Generate agent prompts for Claude Code using the metaphor of Daoist ritual arts.

A Daoist priest draws talismans to command celestial soldiers; a developer writes prompts to drive agents.

---

## Features

| Feature | Description |
|---------|-------------|
| 6 Talisman Templates | Solo Agent, Scout, Builder, Reviewer, Orchestrator, Guardian |
| 6 Base Rituals | Pipeline, Fan-out/Fan-in, Iterative Refinement, Gatekeeper, Expert Panel, Layered Architecture |
| Advanced Rituals | Nested Workflows, Human-in-the-Loop, Fallback Agent |
| Prompt Library | 7 ready-made prompts: Refactor, Test Gen, Translation, DB Migration, API, CI/CD, Security Scan |
| Prompt Linting | 15 auto-check rules across 3 severity levels |
| Token Estimation | Budget estimation formulas and quick-reference cheat sheet |
| Diagnosis Mode | Interactive guide that recommends the best ritual for your task |
| Workflow Diagrams | Auto-generated ASCII / Mermaid topology charts |
| MCP Integration | Guides for Slack, GitHub, Database and other MCP servers |
| Agent SDK Rituals | Python / TypeScript SDK orchestration templates |
| Hooks Integration | Auto-test, constraint enforcement, completion notification hooks |
| Commandment System | 3-layer constraints (Universal/Role/Ceremony) + exemptions + violation reports |
| Enhancement Modules | 6 composable spells (Self-Check/Progress/Meditation/Sandbox/Strict/Verbose) + compatibility matrix |
| Merit & Demerit Record | Invocation audit, 5-dimension scoring, ceremony summary, monthly dashboard |
| Ritual Simulator | Dry run with mock data, verify connections, supports partial rehearsal |
| Ceremony Record | Auto-generated post-mortem reports after complex rituals |
| Template Inheritance | Parent/child talisman system, reduce duplication, enforce shared conventions |

## Installation

```bash
# Default install (Chinese)
bash install.sh

# Choose language
bash install.sh --lang zh   # Chinese
bash install.sh --lang en   # English
```

The install script copies the skill files for the selected language into `~/.claude/skills/`.

## Manual Installation

Copy all files from the desired language folder to your Claude Code skills directory:

```bash
# Chinese
cp zh/*.md ~/.claude/skills/daoist-agent/

# English
cp en/*.md ~/.claude/skills/daoist-agent/
```

## Usage

After installation, in Claude Code:

```
# Describe what you need
> Decree a spirit general to refactor the code under /src/api

# Use Daoist terminology
> Open the altar, summon three generals, use the Five Thunders ritual to translate into three languages in parallel

# Or just say it plainly
> Write me an agent prompt for Claude Code to do code review
```

## File Structure

```
files_dao/
├── README.md                  ← Chinese README (default)
├── README.en.md               ← English README (this file)
├── install.sh                 ← Install script (language selection)
├── zh/                        ← Chinese version
│   └── ...
├── en/                        ← English version
│   └── ...
└── daoist-agent.skill         ← Packaged skill
```

## License

MIT
