# Merit & Demerit Record ── Invocation Audit & Performance Scoring

Every altar opening is recorded. Every agent's summoning, actions, completion, or failure — logged entry by entry.

---

## I. Invocation Log

For each agent decree, record the following:

```markdown
## Invocation Record #[sequence]

| Field | Value |
|-------|-------|
| Timestamp | [ISO 8601 timestamp] |
| Dharma Name | [agent name] |
| Agent Type | [Solo/Scout/Builder/Reviewer/Orchestrator/Guardian] |
| Mission | [one-sentence description] |
| Ritual | [solo / ceremony name] |
| Position | [if in ceremony, which position] |
| Talisman Form | [Flying/Altar Ward/Grand Ceremony] |
| Enhancements | [Self-Check/Progress/Meditation/Sandbox/Strict/Verbose] |
| Token Budget | [estimated tokens] |
| Commandments | [UC-xxx, RC-xxx, CC-xxx] |
| Result | ✅ Complete / ⚠️ Partial / ❌ Failed / ⏸️ User Intervened |
| Actual Tokens | [actual tokens if available] |
| Duration | [duration] |
| Notes | [special circumstances] |
```

---

## II. Performance Scoring

After a ceremony ends, score each agent's performance.

### Scoring Dimensions

| Dimension | Weight | Max | Criteria |
|-----------|--------|-----|----------|
| Mission Completion | 40% | 100 | Degree to which the task objective was achieved |
| Token Efficiency | 20% | 100 | Actual vs estimated (closer is better, overspend penalized) |
| Quality | 20% | 100 | Merit ledger quality, format correctness, completeness |
| Commandment Compliance | 10% | 100 | Violation count and severity (Critical -30, Warning -10, Info -3) |
| Error Handling | 10% | 100 | Quality of tribulation response (graceful degradation +pts, silent failure -pts) |

### Performance Grades

| Grade | Score | Assessment |
|-------|-------|-----------|
| S | 90–100 | Merit complete, exemplary performance |
| A | 80–89 | Mission accomplished with minor flaws |
| B | 70–79 | Meets baseline, room for improvement |
| C | 60–69 | Barely passing, multiple areas need work |
| D | 40–59 | Below standard, review talisman or task design |
| F | 0–39 | Severe failure, requires complete redesign |

### Scoring Report Format

```markdown
# Performance Report

## Agent Info
- Dharma Name: [name]
- Mission: [task]
- Ritual: [ceremony name]

## Dimension Scores

| Dimension | Score | Notes |
|-----------|-------|-------|
| Mission Completion | /100 | [specifics] |
| Token Efficiency | /100 | Estimated XK, Actual YK tokens |
| Quality | /100 | [specifics] |
| Commandment Compliance | /100 | [violations if any, else full marks] |
| Error Handling | /100 | [tribulation handling details, else full marks] |

## Weighted Total: [X] / 100
## Grade: [S/A/B/C/D/F]

## Merit & Demerit Summary
- Merits (practices worth keeping):
  - [specific positive behavior]
- Demerits (areas to improve):
  - [specific issue]

## Improvement Suggestions
- [specific remediation for each demerit]
```

---

## III. Ceremony Summary

After a grand ceremony, consolidate all agents' scores:

```markdown
# Ceremony Scorecard

## Overview
- Ceremony: [name]
- Type: [Pipeline/Fan-out/Iterative/...]
- Start: [start]
- End: [end]
- Duration: [duration]

## Agent Performance Summary

| Agent | Mission | Result | Score | Grade |
|-------|---------|--------|-------|-------|
| [name] | [task] | ✅/⚠️/❌ | [score] | [grade] |
| ... | ... | ... | ... | ... |

## Overall Score
- Average: [X]
- Highest: [agent name] [score]
- Lowest: [agent name] [score]
- Overall Grade: [grade]

## Token Consumption

| Item | Estimated | Actual | Variance |
|------|-----------|--------|----------|
| Total | [X]K | [Y]K | [+/-Z]K ([%]) |
| Position 1 | [X]K | [Y]K | |
| Position 2 | [X]K | [Y]K | |

## Commandment Compliance
- Critical violations: [N]
- Warning violations: [N]
- Info violations: [N]

## Lessons Learned
- Successes: [what went well]
- Improvements: [what could be better]
- Talisman adjustments: [which talismans need revision]
```

---

## IV. Monthly Dashboard

Track long-term trends:

```markdown
# [Month] Monthly Report

## Overview
- Ceremonies conducted: [N]
- Total agents summoned: [N]
- Total token consumption: [X]K

## Agent Type Distribution
| Type | Count | Share |
|------|-------|-------|
| Scout | N | X% |
| Builder | N | X% |
| Reviewer | N | X% |
| ... | ... | ... |

## Ritual Type Distribution
| Ritual | Count | Avg Duration | Avg Score |
|--------|-------|-------------|-----------|
| Pipeline | N | Xm | X |
| Fan-out | N | Xm | X |
| ... | ... | ... | ... |

## Success Rate Trend
| Week | Complete | Partial | Failed |
|------|----------|---------|--------|
| W1 | X% | X% | X% |
| ... | ... | ... | ... |

## Best Performing Talisman
[Which talisman consistently scored highest]

## Needs Improvement
[Which talismans repeatedly failed or scored low]
```
