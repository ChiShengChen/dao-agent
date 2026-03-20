# Ceremony Record ── Post-mortem Report

After complex rituals, automatically generate a ceremony record. Document successes and failures, distill lessons, provide improvement basis for future ceremonies.

---

## When to Write a Ceremony Record

- Ritual involved 3+ generals
- Any agent encountered tribulation failure
- Fallback agents or checkpoints were used
- Duration or token consumption exceeded estimate by 50%+
- Priest explicitly requests it

---

## Ceremony Record Format

```markdown
# Ceremony Record: [Ritual Name]

## Basic Info
- Date: [date]
- Ritual Type: [Pipeline / Fan-out / Iterative / ...]
- Initiated By: [user / auto-trigger]
- Open → Close: [start] → [end] (total [duration])

## Mission Review
- Original Mission: [priest's initial request]
- Final Deliverable: [what was actually delivered]
- Mission Completion: [percentage] — [Complete/Partial/Failed]

## Ceremony Review

### Position Timeline

| # | Position | Agent | Est. Time | Actual Time | Result | Key Events |
|---|----------|-------|-----------|-------------|--------|-----------|
| 1 | [name] | [agent] | Xs | Ys | ✅/⚠️/❌ | [if notable] |
| 2 | ... | ... | ... | ... | ... | ... |

### Tribulation Log

| Position | Description | Severity | Response | Outcome |
|----------|-------------|----------|----------|---------|
| [#] | [description] | 🔴/🟡/🔵 | [strategy] | [success/fail] |

### Degradation Log (if fallback agents used)

| Position | Primary | Fallback | Reason | Quality Impact |
|----------|---------|----------|--------|---------------|
| [#] | [agent] | [agent] | [reason] | [e.g., coverage dropped 100%→60%] |

### Checkpoint Log (if Human-in-the-Loop used)

| Checkpoint | Summary Presented | User Decision | Wait Time |
|-----------|-------------------|--------------|-----------|
| [name] | [summary] | Proceed/Modify/Halt | [duration] |

## Token Accounting

| Item | Estimated | Actual | Variance |
|------|-----------|--------|----------|
| Total | [X]K | [Y]K | [+/-Z]K ([%]) |
| Position 1 | [X]K | [Y]K | |
| Position 2 | [X]K | [Y]K | |

Over/under analysis: [why actual differed from estimate]

## Commandment Compliance
- Critical violations: [N]
- Warning violations: [N]
- Info violations: [N]
- See Merit Record #[id] for details

## Lessons Learned

### What Went Well (Merits)
1. [specific — e.g., Scout's output was well-formatted, Builder needed no extra parsing]
2. [specific]

### What Could Be Better (Demerits)
1. [specific — e.g., data format between Pos 2→3 wasn't aligned, Pos 3 spent extra time parsing]
2. [specific]

### Unexpected Discoveries
- [non-obvious findings — e.g., discovered untracked tech debt in /src/utils]

## Talisman Improvement Suggestions

| Agent | Issue | Suggested Change |
|-------|-------|-----------------|
| [agent] | [problem] | [specific talisman revision] |

## Ritual Improvement Suggestions

| Area | Suggestion |
|------|-----------|
| Position arrangement | [e.g., Pos 2 and 3 can run in parallel instead of sequential] |
| Tribulation plans | [e.g., need to add fallback agent for Pos 4] |
| Token budget | [e.g., Scout can use haiku instead of sonnet] |
| Enhancements | [e.g., Builder should have Self-Reflection added] |

## Action Items
- [ ] [specific improvement action 1]
- [ ] [specific improvement action 2]
- [ ] [specific improvement action 3]
```

---

## Auto-trigger Ceremony Record

Add this to the Orchestrator decree to auto-generate post-mortem:

```
After ceremony completion (or halt due to tribulation):
1. Collect all position merit ledgers and tribulation logs
2. Generate a review report following the "Ceremony Record" format
3. Store at [altar root]/postmortem/[date]-[ritual-name].md
4. Present action item summary to the priest
```

---

## Ceremony Record vs Merit Record

| Aspect | Merit Record | Ceremony Record |
|--------|-------------|-----------------|
| Focus | Individual agent performance | Entire ritual operation |
| Granularity | Agent-level | Ceremony-level |
| Content | Scores and grades | Flow review and lessons learned |
| Purpose | Optimize talismans | Optimize ritual design |
| Trigger | After each agent completes | After entire ceremony completes |
