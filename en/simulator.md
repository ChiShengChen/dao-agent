# Ritual Simulator ── Dry Run

Before the real ceremony, rehearse with illusions. Walk through the complete ritual with mock data to verify altar connections, data flow, and tribulation contingencies — without consuming real spiritual power.

---

## When to Rehearse

- Ritual involves 3+ generals
- Ritual has nested structures
- Task involves production environment or irreversible operations
- First time using a new talisman or ritual formation
- Priest wants to verify the flow before committing

---

## Rehearsal Procedure

### Step 1: Prepare Mock Input

Prepare simplified mock data matching the real input format:

```
Mock Input:
- Type: [same format as real input]
- Content: [simplified — 3-5 representative items]
- Location: /tmp/rehearsal/[ritual-name]/input/

Example:
If real input is 1000 Python files, mock input needs only 3:
- mock_simple.py (normal case)
- mock_edge.py (edge case)
- mock_error.py (expected to trigger tribulation)
```

### Step 2: Enable Rehearsal Mode

Add the rehearsal marker to the Orchestrator decree:

```
⚙️ Rehearsal Mode Active

This is a dry run. Follow these rules:
1. Use /tmp/rehearsal/ as the altar root directory
2. Do not access real data sources
3. Do not execute any external API calls (simulate responses instead)
4. Do not push any changes to remote
5. All "write" operations write only to the rehearsal altar
6. Every agent prefixes their merit ledger with "[REHEARSAL]"

Rehearsal Goals:
- Verify the ritual flow completes end-to-end
- Verify data format compatibility between altar positions
- Verify tribulation contingencies trigger correctly
- Measure approximate duration and token consumption
```

### Step 3: Execute Rehearsal

Run the full ritual procedure using mock input and the rehearsal altar.

### Step 4: Rehearsal Debrief

After rehearsal, produce a debrief report:

```markdown
# Rehearsal Debrief

## Overview
- Ritual: [name]
- Type: [type]
- Positions: [N]
- Rehearsal Duration: [duration]

## Flow Verification

| # | Position | Agent | Status | Notes |
|---|----------|-------|--------|-------|
| 1 | [name] | [agent] | ✅ Pass | |
| 2 | [name] | [agent] | ✅ Pass | |
| 3 | [name] | [agent] | ⚠️ Warning | [data format slight mismatch] |
| 4 | [name] | [agent] | ❌ Fail | [tribulation plan didn't cover this case] |

## Data Flow Verification

| Source → Target | Format | Result |
|----------------|--------|--------|
| Pos 1 → Pos 2 | JSON | ✅ Correct format, all fields present |
| Pos 2 → Pos 3 | Markdown | ⚠️ Missing `summary` field |

## Tribulation Plan Verification
- mock_error.py triggered tribulation: [handled correctly?]
- Fallback agent activation: [triggered as expected?]
- Checkpoint pause: [paused correctly?]

## Token Estimate
- Rehearsal consumption: [X]K tokens (with mock data)
- Estimated real consumption: [Y]K tokens (scaled by data volume ratio)

## Issues Found
1. [issue description] → [suggested fix]
2. [issue description] → [suggested fix]

## Rehearsal Verdict
- ✅ Ready for production (flow unblocked)
- ⚠️ Ready after fixes (minor issues to address first)
- ❌ Not ready (critical issues require redesign)
```

---

## Rehearsal vs Production

| Item | Rehearsal | Production |
|------|-----------|------------|
| Altar | /tmp/rehearsal/ | Real directory |
| Input | Mock data (3-5 items) | Real data |
| API calls | Simulated responses | Real calls |
| Write operations | Rehearsal altar only | Real targets |
| Remote push | Forbidden | Per decree |
| Merit ledger prefix | [REHEARSAL] | (none) |
| Token consumption | ~10-20% of real | 100% |

---

## Partial Rehearsal

You don't need to run the full ritual every time. Test specific positions or connections:

```
Partial Rehearsal: Position 2 → Position 3 Connection Test

Purpose: Verify Position 2's output format can be correctly read by Position 3.

Steps:
1. Manually prepare mock output from Position 2 (or reuse artifacts from a previous rehearsal)
2. Decree only Position 3's agent with the mock output as input
3. Confirm Position 3 correctly reads and processes it

Use Cases:
- After modifying an agent's talisman, verify connection with upstream/downstream
- When adding a new position, verify compatibility with existing positions
```
