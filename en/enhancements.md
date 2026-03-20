# Enhancement Modules ── Composable Spells

Six enhancement modules, each with a distinct purpose. Use individually or stack on any talisman.

---

## I. Self-Reflection Spell (Self-Check)

Post-completion self-verification to ensure output is flawless.

**Trigger**: Automatically when the agent declares completion.

```
After completion, perform the following self-check (max 3 rounds):

Round 1: Format Verification
1. Re-read your merit ledger and confirm format matches decree requirements
2. Confirm all required fields are populated

Round 2: Completeness Verification
3. Cross-check each requirement in the decree, confirm nothing was missed
4. Verify all output paths actually exist and are accessible

Round 3: Quality Verification
5. Check if output content is reasonable (no obvious contradictions or errors)

If flaws are found, fix and re-check. After 3 rounds, flag remaining issues at the end of the merit ledger.
```

---

## II. Progress Report Spell

Report execution progress during multi-step tasks.

**Trigger**: At ceremony start, after each stage, at completion.

```
Report progress at these checkpoints:

At start:
[REPORT] Opening | N stages total | Mission: [one sentence]

After each stage:
[REPORT] Stage M/N | [stage name] | ✅ Complete | Duration Xs

On tribulation:
[REPORT] Stage M/N | [stage name] | ❌ Tribulation | [cause summary]

At completion:
[REPORT] Closing | N/N stages done | Total Xs | [merit summary]
```

---

## III. Meditation Spell (Thinking Trigger)

Deliberate before acting at critical decision points, reducing impulsive errors.

**Trigger**: When facing multiple paths, uncertain cascading effects, or trade-offs.

```
At the following junctions, deliberate in <thinking> before acting:

1. When facing multiple approaches — list pros/cons of each before choosing
2. When unsure if a change might cascade to other areas — first map the blast radius
3. When needing to trade off speed vs quality — clarify the priority for this context
4. Before executing irreversible operations — confirm a rollback plan exists

Deliberation format:
<thinking>
Path A: [description] → Pros: [...] / Cons: [...]
Path B: [description] → Pros: [...] / Cons: [...]
Choice: [Path X], because [reason]
</thinking>
```

---

## IV. Sandbox Spell

Seal the agent's access boundaries — restrict paths, tools, and network.

**Trigger**: Automatically checked whenever the agent attempts to access any resource.

```
Sandbox Configuration:

Path Restrictions:
- Allow Read: [path list, supports glob patterns]
- Allow Write: [path list]
- Deny Access: [path list]
  Example:
  - Allow Read: /src/**/*、/tests/**/*、/docs/**/*
  - Allow Write: /src/**/*、/tests/**/*
  - Deny Access: /node_modules/**、/.env*、/credentials*、/.git/**

Tool Restrictions:
- Allow: [tool list]
- Deny: [tool list]
  Example:
  - Allow: Read, Edit, Write, Grep, Glob, Bash(only npm test, npm run lint)
  - Deny: Bash(all commands except whitelist)

Network Restrictions:
- Allow: [domain/IP list]
- Deny: [domain/IP list]
  Example:
  - Allow: api.github.com、registry.npmjs.org
  - Deny: *.internal.company.com、10.*.*.*、192.168.*.*

Violation Response:
- Reading denied zone: log attempt + skip
- Writing to denied zone: 🔴 immediate seal
- Using denied tool: 🔴 immediate seal
```

---

## V. Strict Mode (Diamond Commandment)

Halt on any error — never proceed wounded. For high-risk operations.

**Trigger**: On any unexpected behavior.

```
Strict Mode Active:

Rules:
1. Any command returning non-zero exit code → immediate halt
2. Any file operation failure → immediate halt
3. Any output not matching expected format → immediate halt
4. Any commandment violation → immediate halt

On Halt:
- Do not attempt automatic recovery
- Do not skip the failed step
- Package the following for the priest:
  1. Halt point (which step stopped)
  2. Error message (complete error output)
  3. Completed stages list
  4. Remaining stages list
  5. Current altar state (which files were modified)
  6. Suggested manual intervention plan

Interaction with other enhancements:
- Self-Reflection: Strict Mode takes priority — if self-check finds issues, halt immediately instead of fixing
- Progress Report: automatically send final report on halt
```

---

## VI. Verbose Log (All-Seeing Eye)

Log every operation in detail for debugging and traceability.

**Trigger**: Before and after every operation.

```
Verbose Log Active:

Log Format:
[LOG] [timestamp] [operation type] [details]

Logged Items:
1. Every file read: [LOG] READ /path/to/file (NNN bytes)
2. Every file write: [LOG] WRITE /path/to/file (NNN bytes, +X/-Y lines)
3. Every command: [LOG] EXEC `command` → exit code N (Xms)
4. Every decision: [LOG] DECIDE [optionA|optionB|...] → chose [X] because [reason]
5. Every error: [LOG] ERROR [type] [message] at [location]
6. Every skip: [LOG] SKIP [operation] because [reason]

Log Storage:
- Default: output to stdout (included in merit ledger)
- Configurable: write to separate log file at [specified path]

Note: Verbose Log significantly increases output volume, approximately 30-50% more token consumption.
```

---

## Compatibility Matrix

Enhancement modules have synergies and conflicts — don't stack blindly.

### Synergies (Recommended Combinations)

| Combination | Effect |
|-------------|--------|
| Self-Reflection + Progress Report | Self-check results included in final report, complete tracking |
| Meditation + Sandbox | Deliberation considers sandbox limits, more practical decisions |
| Progress Report + Verbose Log | Reports provide overview, logs provide detail, complementary |
| Sandbox + Strict Mode | Boundary violation = immediate halt, double protection |

### Conflicts (Avoid Combining)

| Combination | Issue |
|-------------|-------|
| Strict Mode + Verbose Log | ⚠️ Verbose output may trigger Strict Mode's "unexpected output" check. If both needed, Strict Mode must exclude Verbose Log output |
| Strict Mode + Self-Reflection | ⚠️ Self-check finding issues will trigger Strict Mode halt instead of allowing auto-fix. If both needed, Strict Mode temporarily downgrades during self-check phase |
| Verbose Log × Multiple Parallel Agents | ⚠️ Multiple agents with Verbose Log produce interleaved logs. Must set independent log paths for each agent |

### Stacking Limit

- Recommended maximum: **3 enhancements** simultaneously
- More than 3 significantly increases prompt length and token consumption
- High-risk scenarios: Sandbox + Strict Mode + Progress Report
- Debugging scenarios: Verbose Log + Self-Reflection + Progress Report
- Everyday scenarios: Self-Reflection + Meditation
