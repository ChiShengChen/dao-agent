# Token Estimation ── Budget Planning

Before drawing a talisman, estimate the spiritual power needed. A talisman too short has no power; too long and the spell backfires. This guide helps estimate a reasonable token budget.

---

## Token Measurements

### Talisman Size (Prompt Tokens)

| Talisman Type | Recommended Length | Approx. Tokens |
|--------------|-------------------|----------------|
| Flying Talisman (one-shot `claude -p`) | Short and focused | 150–400 |
| Solo Agent Talisman | Moderate | 300–600 |
| Scout / Builder / Reviewer | Medium-detailed | 400–800 |
| Orchestrator Talisman | Detailed | 600–1200 |
| Altar Ward (CLAUDE.md) | Complete | 500–1500 |
| Grand Ceremony (multi-talisman) | Count each separately | 300–800 per talisman |

### Agent Execution (Completion Tokens)

Estimate based on task complexity:

| Task Type | Est. Turns | Tokens/Turn | Total |
|-----------|-----------|-------------|-------|
| Simple query/search | 1–3 | 500–1000 | 1K–3K |
| Single file modification | 2–5 | 1000–2000 | 2K–10K |
| Multi-file refactoring | 5–15 | 1500–3000 | 8K–45K |
| Complete feature development | 10–25 | 2000–4000 | 20K–100K |
| Grand ceremony (multi-agent) | Per-agent | — | 50K–500K |

---

## Estimation Formulas

### Single Agent

```
Total Tokens ≈ Talisman Tokens + (Turns × Tokens/Turn) + Tool Call Overhead

Where:
- Talisman Tokens: from table above
- Turns: based on task complexity
- Tokens/Turn: based on output size
- Tool Call Overhead: ~200–500 tokens per tool invocation (input + output)
```

### Iterative Refinement (Nine-Turn Elixir)

```
Total ≈ Turns × (Builder Tokens + Reviewer Tokens)

Typically:
- 1 turn success: 2× single-pass tokens
- 2 turn success: 4× single-pass tokens
- 3 turn success: 6× single-pass tokens

Budget at 80% of max turns (most won't go to the final turn)
```

### Fan-out / Fan-in (Five Thunders)

```
Total ≈ Vanguard + Σ(Each Thunder God) + Merger

Note: Parallel execution saves time, not tokens.
N parallel tracks ≈ N × single track tokens
```

### Layered Architecture (Trinity)

```
Total ≈ Heaven Layer (decisions) + Σ(Human Layer agents) + Earth Layer (monitoring)

Heaven Layer is usually lightest (just dispatching): ~2K
Human Layer is the main cost: estimate each agent separately
Earth Layer depends on monitoring frequency: ~1K–5K
```

---

## Quick Estimation Table

Answer these questions, then look up the budget:

### Question 1: How many agents?

| Agent Count | Base Multiplier |
|-------------|----------------|
| 1 | ×1 |
| 2–3 | ×2.5 |
| 4–6 | ×5 |
| 7+ | ×8+ |

### Question 2: How complex?

| Complexity | Base Tokens | Typical Scenarios |
|-----------|-------------|-------------------|
| Simple (one step) | 2K | Search, simple edit, format conversion |
| Medium (3–5 steps) | 10K | Multi-file edit, test generation, code review |
| Complex (10+ steps) | 30K | Full feature dev, large refactoring |
| Extreme (open exploration) | 80K+ | Architecture design, complex debugging, full project analysis |

### Question 3: Any iteration?

| Iteration Mode | Additional Multiplier |
|---------------|----------------------|
| None | ×1 |
| Max 2 turns | ×1.8 |
| Max 3 turns | ×2.5 |
| Max 5 turns | ×4 |

### Calculation

```
Estimated Total = Base Tokens × Agent Multiplier × Iteration Multiplier

Examples:
- 3 agents, medium task, no iteration: 10K × 2.5 × 1 = 25K tokens
- 1 agent, complex task, 3-turn iteration: 30K × 1 × 2.5 = 75K tokens
- 5 agents, complex task, 2-turn iteration: 30K × 5 × 1.8 = 270K tokens
```

---

## Token-Saving Techniques

### 1. Choose the Right Model

| Scenario | Recommended Model | Cost |
|----------|------------------|------|
| Simple search, format conversion | claude-haiku-4-5 | Low |
| General development, review | claude-sonnet-4-6 | Medium |
| Complex reasoning, architecture decisions | claude-opus-4-6 | High |

In talismans, you can specify:
```
Model Configuration:
- Scout (reconnaissance): use haiku, saves tokens
- Builder (core development): use sonnet
- Orchestrator (decisions): use opus
```

### 2. Trim the Talisman

- Remove redundant explanations and background, keep only commands
- Use concise format definitions instead of verbose descriptions
- Provide one example, not three

### 3. Narrow the Scope

- Specify target files explicitly, don't let agents search the entire altar
- Use glob patterns to narrow scope: `src/**/*.ts` not `**/*`
- Let Scout reconnoiter first, then Builder acts on specific targets

### 4. Use max_turns Wisely

- Set reasonable `max_turns` to prevent agents from running indefinitely
- Simple tasks: 3–5 turns
- Medium tasks: 5–15 turns
- Complex tasks: 15–30 turns

---

## Quick Reference Chant

```
A talisman starts at three hundred, eight hundred is the ceiling.
One agent starts at two thousand, a hundred thousand for grand works.
Parallel saves no power, only saves marching time.
Iteration doubles the count, three rounds multiply by three.
Match model to cultivation — don't use an ox to kill a chicken.
```
