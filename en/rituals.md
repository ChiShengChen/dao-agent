# Grand Ceremony Compendium ── Multi-Agent Workflow Patterns

When multiple generals collaborate in a ceremony, the ritual arrangement determines success or failure. Below are proven classic ritual formations.

---

## Ritual I: Stepping the Stars (Pipeline)

From the Daoist practice of "stepping the stars of the Big Dipper" — the priest steps through star positions in strict sequence, each step connecting to the next.

```
[General A] → [General B] → [General C] → Complete
```

**Suitable For**: Tasks with clear sequential stages, where each stage's output feeds the next.

**Typical Tasks**:
- Data processing: Collect → Clean → Transform → Load
- Code workflow: Generate → Review → Test → Deploy
- Document processing: Extract → Translate → Format

**Key Principles**:
- Altars communicate through artifacts (files), using a unified intermediate format
- Each stage writes output to an agreed location; the next stage reads from there
- All intermediate artifacts are preserved, never destroyed, for traceability

**Orchestrator Decree Fragment**:
```
Execute in star-step sequence:
1. Decree [General A] to begin, output to /tmp/pipeline/step1/
2. Confirm /tmp/pipeline/step1/ contains expected artifacts
3. Decree [General B], take /tmp/pipeline/step1/ as input, output to /tmp/pipeline/step2/
4. Confirm /tmp/pipeline/step2/ contains expected artifacts
5. Decree [General C], take /tmp/pipeline/step2/ as input, output to /tmp/pipeline/final/
If any stage encounters a tribulation, halt the ceremony immediately and report the failed stage and cause.
```

---

## Ritual II: Five Thunders (Fan-out / Fan-in)

From the Daoist "Five Thunders Righteous Method" — at the priest's command, thunder gods in five directions respond simultaneously, each fulfilling their duty, then converging in one mighty strike.

```
               ┌→ [Thunder A] →┐
[Vanguard] →   ├→ [Thunder B] →┤  → [Merger] (consolidation)
               └→ [Thunder C] →┘
```

**Suitable For**: Tasks that can be split into independent parallel tracks, converging at the end.

**Typical Tasks**:
- Multi-language translation: One document translated into multiple languages simultaneously
- Parallel testing: Same artifact tested in multiple environments
- Multi-angle analysis: Same data analyzed from different perspectives

**Key Principles**:
- Each thunder god is fully independent, unaware of the others
- Each stores output in its own sub-altar
- The Merger reads all sub-altars and consolidates
- Plan for partial failure — the Merger must handle "M of N succeeded"

**Orchestrator Decree Fragment**:
```
1. Decree [Vanguard] to prepare input, store at /tmp/thunder/input/
2. Simultaneously decree the following (each independent):
   - [Thunder A] takes /tmp/thunder/input/, output to /tmp/thunder/a/
   - [Thunder B] takes /tmp/thunder/input/, output to /tmp/thunder/b/
   - [Thunder C] takes /tmp/thunder/input/, output to /tmp/thunder/c/
3. Wait for all thunder gods to complete
4. Decree [Merger] to consolidate /tmp/thunder/a/, b/, c/, output to /tmp/thunder/final/
```

---

## Ritual III: Nine-Turn Elixir (Iterative Refinement)

From the Daoist art of elixir cultivation — an elixir must be refined through nine turns to reach perfection. If the first turn fails, refine again; if the second fails, try a third. Until the elixir is complete.

```
[Builder (refine)] → [Reviewer (test)] → Failed? → Back to refining
                                        → Passed? → Complete
```

**Suitable For**: Tasks requiring repeated refinement until a quality bar is met.

**Typical Tasks**:
- Code generation + code review loop
- Content writing + editorial refinement
- Design iteration + feedback correction

**Key Principles**:
- Set a maximum number of turns (usually 3–5) to avoid infinite loops
- The Reviewer must produce a structured report (not just "failed" — explain what failed and why)
- Preserve intermediate artifacts from each turn — first-turn draft, second-turn draft, each kept separately
- From the second turn onward, the Builder receives "previous draft + reviewer's report"

**Orchestrator Decree Fragment**:
```
Refine for at most [N] turns:
1. Decree [Builder] to create/modify the artifact, store at /tmp/elixir/v{N}/draft
2. Decree [Reviewer] to test /tmp/elixir/v{N}/draft
3. If Reviewer approves (no critical issues), move draft to /tmp/elixir/final/ and close
4. If Reviewer rejects, send report + draft together into the next turn
5. If max turns reached and still not approved, take the last draft and attach all unresolved reports for the priest
```

---

## Ritual IV: Gate Guardian (Gatekeeper)

From the Daoist concept of "passing gates" in cultivation — each gate has a guardian who verifies identity before granting passage.

```
[Input] → [Guardian (validate in)] → Pass → [Worker] → [Guardian (validate out)] → Output
                                    → Fail → Reject / Report
```

**Suitable For**: Tasks requiring safety/quality gates before and after the core work.

**Typical Tasks**:
- API input validation → Processing → Output validation
- Code commit → Security scan → Compliance check
- Data import → Schema validation → Quality inspection

**Key Principles**:
- The Guardian can be the same agent for entry and exit (same talisman), or different agents (strict entry, lenient exit, or vice versa)
- Rejection must include a reason — never just "failed"
- Urgent items may have "special passage" conditions, but these must be logged in the merit ledger

---

## Ritual V: Three Pure Ones Council (Expert Panel)

From the Three Pure Ones of Daoism — Jade Pure, Upper Pure, Grand Pure — each representing a different perspective of the Dao, deliberating on matters of heaven and earth together.

```
               ┌→ [Jade Pure (Perspective A)] →┐
[Task] →       ├→ [Upper Pure (Perspective B)] →┤  → [Grand Arbiter (synthesize)] → Final Decision
               └→ [Grand Pure (Perspective C)] →┘
```

**Suitable For**: Tasks requiring multi-angle comprehensive evaluation.

**Typical Tasks**:
- Technology selection: Performance expert + Security expert + Maintainability expert
- Risk assessment: Financial + Legal + Technical perspectives
- Architecture decisions: Scalability, simplicity, performance — three perspectives

**Key Principles**:
- All three Pure Ones receive the same input but have different talismans (emphasizing different analytical angles)
- The Grand Arbiter must have clear decision rules (weighted scoring, voting, or other mechanism)
- The Pure Ones do not communicate with each other, only with the Arbiter — to avoid mutual influence

---

## Ritual VI: Heaven-Earth-Human Trinity (Layered Architecture)

From the Daoist concept of "Three Powers" — Heaven covers, Earth supports, Humanity dwells between.

```
[Heaven Layer: Grand Orchestrator] ── Strategic decisions, task dispatch
        ↕
[Human Layer: Specialist Generals] ── Execute specific tasks
        ↕
[Earth Layer: Guardian Foundation] ── Monitoring, logging, error handling
```

**Suitable For**: Large systems requiring layered management.

**Key Principles**:
- Heaven Layer only makes decisions and dispatches — never touches specific tasks
- Human Layer agents each hold their duty, communicating through the filesystem
- Earth Layer runs silently, only reporting upward when anomalies appear
- Each layer has its own independent altar (directory), never mixed

---

## Ritual Selection Guide

| Scenario | Recommended Ritual |
|----------|-------------------|
| Task has clear sequential stages | Stepping the Stars |
| Task can be split into parallel tracks | Five Thunders |
| High quality bar, needs iterative refinement | Nine-Turn Elixir |
| Task needs pre/post validation gates | Gate Guardian |
| Needs multi-perspective comprehensive judgment | Three Pure Ones Council |
| Large system with layered management | Heaven-Earth-Human Trinity |
| Combinations of the above | Nested Rituals — embed sub-rituals within ritual nodes |

## Fundamental Laws

1. **The altar is the only channel** — generals communicate through artifacts (files), never attempt stdout or environment variables for complex data
2. **Altars do not intrude on each other** — each general's working directory must be isolated to prevent artifact conflicts
3. **Artifacts must never be destroyed** — all intermediate outputs are preserved for traceability
4. **Set a ceremony time limit** — the entire ritual should not exceed a reasonable duration
5. **Test with a small altar first** — run the complete ritual with simple input to verify the process before scaling up
6. **Follow the Dao of simplicity** — if one general can solve it, don't summon three; simplicity is the great Dao
