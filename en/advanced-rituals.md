# Advanced Rituals ── Advanced Workflow Patterns

Beyond the six base rituals: nested rituals, human-in-the-loop, and fallback agents.

---

## Ritual VII: Nested Rituals (Nested Workflows)

A grand ceremony within a grand ceremony. Use base rituals as building blocks and compose freely.

### Composition Principles

Any altar position in a ritual can be replaced with a complete sub-ritual. For example:

**Pipeline × Iterative Refinement:**
```
[Scout] → [Nine-Turn Elixir (code gen + review loop)] → [Deployer]
```

**Fan-out × Gatekeeper:**
```
              ┌→ [Gatekeeper (validate→translate A→validate)] →┐
[Prep Agent] →├→ [Gatekeeper (validate→translate B→validate)] →┤→ [Merger]
              └→ [Gatekeeper (validate→translate C→validate)] →┘
```

**Trinity × Expert Panel:**
```
[Heaven: Orchestrator]
    ↓ dispatch tasks
[Human: Expert Panel (multi-angle evaluation)] → decision
    ↓ execute decision
[Earth: Guardian monitoring]
```

### Nested Generation Procedure

When a user's requirements involve multi-layered structure, generate as follows:

1. **Draw the overview** — sketch the overall topology in ASCII or Mermaid first
2. **Mark nesting points** — which altar positions need to expand into sub-rituals
3. **Generate inside-out** — generate innermost sub-ritual talismans first, then outer layers
4. **Define interface artifacts** — inputs and outputs between layers must align precisely
5. **Set nested tribulation handling** — how sub-ritual failures propagate to outer layers

### Nested Decree Fragment

```
Main Ritual: Pipeline
  Position 1: [Scout] reconnaissance
  Position 2: 【Sub-Ritual: Nine-Turn Elixir】
    Refiner: [Builder] generates code based on Position 1 results
    Reviewer: [Reviewer] audits the code
    Max 3 turns
    Sub-ritual output: /tmp/nested/inner/
  Position 3: [Deployer] takes /tmp/nested/inner/final/ and deploys

Nested Tribulation Handling:
- If sub-ritual fails after 3 turns, submit last draft + all reports to Position 3
- Position 3, upon receiving flagged artifacts, deploys to staging only
```

### Nesting Depth Rules

- **Maximum 3 levels of nesting** — beyond three, the complexity becomes unmanageable; redesign instead
- **Each level has its own altar** — `/tmp/ritual/L1/`, `/tmp/ritual/L1/sub1/`
- **Sub-rituals are black boxes to outer layers** — outer layers see only the final output, not internal details

---

## Ritual VIII: Human-in-the-Loop

At critical altar positions, pause and wait for the priest (user) to personally review and confirm before proceeding. For high-risk operations.

### Formation

```
[Agent A] → ⏸️ User Confirmation → [Agent B] → ⏸️ User Confirmation → [Agent C]
```

### Suitable For

- Production deployments
- Data deletion or irreversible operations
- Outbound communications (email, messages, API calls)
- Financial or contractual operations

### Checkpoint Wording

At positions that need pausing, use this pattern:

```
⏸️ Checkpoint: [checkpoint name]

Pause here and present the following to the user:

Status Report:
- Completed: [summary of previous stage results]
- Next action: [specific operation about to be performed]
- Blast radius: [what this operation affects]
- Reversible: [yes/no, and how to reverse]

Await user command:
- "Proceed" → continue execution
- "Modify" → adjust per user's new instructions, then re-present
- "Halt" → stop the ceremony, preserve current output
```

### Orchestrator Decree Fragment (with checkpoints)

```
Execute sequentially, pausing at checkpoints:

1. Decree [Scout] to scan production environment status, output to /tmp/deploy/scan/
2. ⏸️ Checkpoint "Deployment Confirmation":
   Present scan results and version diff about to be deployed
   Await user confirmation
3. Decree [Deployer] to execute deployment, output to /tmp/deploy/result/
4. Decree [Guardian] to monitor health metrics for 5 minutes post-deploy
5. ⏸️ Checkpoint "Rollback Decision":
   Present health metrics
   If user determines anomaly, execute rollback procedure
```

### Design Principles

- **Reports must be comprehensive** — the user should not need to investigate separately to make a decision
- **Default is "Halt"** — if the user does not respond for an extended time, do not proceed autonomously
- **Log all decisions** — record every confirmation/rejection in the merit ledger for traceability
- **Checkpoints cannot be skipped** — even if everything looks fine, mandatory pause points must pause

---

## Ritual IX: Fallback Agent

When a primary general fails, automatically activate a fallback agent that retries with a different strategy.

### Formation

```
[Primary] → Success → Continue
    │
    └→ Failed → [Fallback A (Strategy B)] → Success → Continue
                        │
                        └→ Failed → [Last Resort (Simplest Strategy)] → Success/Report
```

### Suitable For

- Primary strategy may fail due to environment differences (e.g., a tool isn't installed)
- Graceful degradation needed (try the best approach first, fall back if it fails)
- External dependencies are unstable (API timeouts, service outages)

### Fallback Strategy Types

| Strategy | Description | Example |
|----------|-------------|---------|
| Tool Swap | Use a different tool for the same task | `ripgrep` unavailable → fall back to `grep` |
| Degraded Execution | Lower quality bar but complete the task | Full analysis → Sampled analysis |
| Divide and Conquer | Split large task into smaller retries | Whole-directory processing fails → file-by-file processing |
| Alternate Route | Use a completely different method | API call fails → read from cache |
| Manual Handoff | Give up automation, prepare a report for the user | Log failure reasons + manual step checklist |

### Orchestrator Decree Fragment (with fallbacks)

```
Decree [Code Analysis General]:
  Primary Strategy: Use AST parser to analyze [language] code
  Fallback Strategies:
    Fallback 1: Use regex search
      Trigger: AST parser fails or doesn't support this language
    Fallback 2: Line-by-line text search
      Trigger: Regex search also fails
    Last Resort: Compile file list and error messages into a report for the user
      Trigger: All automated strategies have failed

Each degradation must record:
- Why the primary strategy failed
- Which fallback level was used
- Quality assessment after degradation (e.g., "coverage dropped from 100% to 60%")
```

### Fallback Talisman Structure

Write independent talismans for primary and fallback agents, but define trigger relationships in the orchestrator talisman:

```
Agent Configuration:
  Primary:
    Name: AST Analysis Master
    Talisman: [primary talisman content]
    Success Criteria: merit ledger exists and is non-empty

  Fallback 1:
    Name: Regex Search Agent
    Talisman: [fallback talisman content]
    Trigger: primary merit ledger doesn't exist OR primary reported tribulation
    Additional Input: primary's tribulation log (so fallback knows what went wrong)

  Last Resort:
    Name: Report Agent
    Talisman: Collect all tribulation logs and compile into a human-readable report
    Trigger: Fallback 1 also failed
```

### Fallback Design Rules

- **Fallbacks must never be more complex than the primary** — each level is simpler; this is degradation, not escalation
- **Every degradation must be logged** — the final merit ledger must state which strategy level was used
- **Fallback altars are independent** — don't overwrite the primary's partial work; each saves to its own location
- **Maximum 3 fallback levels** — primary + 2 fallbacks + last resort report; more than that means the task needs redesign
