# Tool Integration ── External System Connections

Incorporating external tools (MCP Servers, Agent SDK, Hooks) into the talisman system.

---

## I. MCP Tool Integration

MCP (Model Context Protocol) servers are external abilities that agents can invoke. When including MCP tools in talismans, follow these guidelines.

### MCP Tool Categories

| Category | MCP Server Examples | Usage |
|----------|-------------------|-------|
| Communication | Slack MCP | Send messages, notifications, ask people |
| Vision | GitHub MCP | Read PRs, Issues, code |
| Creation | Filesystem MCP | Read/write files, manage altars |
| Query | Database MCP / Postgres MCP | Query data, verify schema |
| Remote Fetch | Fetch MCP | Call external APIs, scrape web pages |
| Observation | Sentry MCP / Datadog MCP | Monitoring, error tracking |

### Writing MCP Tools into Talismans

Explicitly list MCP tools in the "Tool Inventory" section:

```
Tool Inventory:
- Built-in Tools: Read, Edit, Write, Bash, Grep, Glob
- MCP Tools:
  - github: create_pull_request, list_issues, get_pull_request_diff
  - slack: send_message (only to #deploy-notifications channel)
  - postgres: query (SELECT only, no INSERT/UPDATE/DELETE)
- Forbidden:
  - slack: all channels except #deploy-notifications
  - postgres: any write operations
  - any MCP tool not listed above
```

### MCP Constraint Examples

```
MCP Constraints:
- Slack: do not send @channel or @here
- GitHub: do not merge PRs, only create and comment
- Database: queries must have LIMIT, max 1000 rows
- Fetch: do not access internal network addresses (10.x.x.x, 192.168.x.x)
```

### Complete Talisman Example with MCP

```
You are a PR Patrol Scout.

Mission: Scan all open PRs in [repo], find those unreviewed for 7+ days, and notify via Slack.

Tool Inventory:
- MCP Tools:
  - github: list_pull_requests, get_pull_request
  - slack: send_message (only to #code-review channel)

Ritual:
1. Use github.list_pull_requests to get all PRs with state=open
2. Filter for those where created_at is 7+ days ago and review count is 0
3. For each matching PR, use github.get_pull_request for details
4. Compile into a summary and use slack.send_message to post to #code-review
5. Message format:
   ```
   🔍 The following PRs have been unreviewed for 7+ days:
   - #123 [Title] by @author (N days ago)
   - #456 [Title] by @author (N days ago)
   Please take a moment to review.
   ```

Seals:
- Do not use @channel or @here
- Do not include code content in the Slack message
- If no PRs match the criteria, do not send a message (silent completion)

Completion Criteria:
Scan complete, matching PRs notified (or confirmed none needed notification).
```

---

## II. Claude Agent SDK Rituals

Use the Python or TypeScript Agent SDK for programmatic ritual orchestration, ideal for scenarios requiring code-level control flow.

### When to Use SDK vs CLI

| Scenario | `claude -p` (Flying Talisman) | Agent SDK |
|----------|------------------------------|-----------|
| One-time task | ✅ | ❌ Overkill |
| Fixed pipeline | ⚠️ Shell scripting works | ✅ Better control |
| Dynamic branching | ❌ Difficult | ✅ The right tool |
| Persistent state needed | ❌ Stateless | ✅ Manageable |
| Error retry & degradation | ❌ Manual | ✅ Programmatic |
| Multi-agent parallel | ⚠️ Background jobs | ✅ async/await |

### Python SDK Pipeline Template

```python
"""
Ceremony: [Ritual Name]
Orchestrate multiple generals with the Claude Agent SDK.
"""
import asyncio
from claude_code_sdk import Claude, ClaudeOptions

async def main():
    # ── I. Define each general's talisman ──
    scout_talisman = """
    You are a Scout General.
    Mission: [reconnaissance task]
    Merit Ledger: output as JSON to stdout
    """

    builder_talisman = """
    You are a Builder Master.
    Mission: [build task]
    Input: [description of upstream output]
    """

    reviewer_talisman = """
    You are a Reviewer.
    Mission: [review task]
    Report Format: [format definition]
    """

    # ── II. Pipeline (Stepping the Stars) ──
    # Stage 1: Scout reconnaissance
    scout_result = await Claude.create(
        prompt=scout_talisman,
        options=ClaudeOptions(
            max_turns=5,
            model="claude-sonnet-4-6",
        )
    )

    # Stage 2: Builder creates (with scout results)
    builder_result = await Claude.create(
        prompt=f"{builder_talisman}\n\nInput (scout results):\n{scout_result}",
        options=ClaudeOptions(
            max_turns=10,
            model="claude-sonnet-4-6",
        )
    )

    # Stage 3: Reviewer audits
    review_result = await Claude.create(
        prompt=f"{reviewer_talisman}\n\nArtifact under review:\n{builder_result}",
        options=ClaudeOptions(
            max_turns=5,
            model="claude-sonnet-4-6",
        )
    )

    print(f"Ceremony complete. Review report:\n{review_result}")

asyncio.run(main())
```

### Python SDK Fan-out / Fan-in Template

```python
"""
Ceremony: Five Thunders (Fan-out / Fan-in)
Multiple parallel tracks, final consolidation.
"""
import asyncio
from claude_code_sdk import Claude, ClaudeOptions

async def summon_agent(talisman: str, offering: str) -> str:
    """Decree a general."""
    return await Claude.create(
        prompt=f"{talisman}\n\nInput:\n{offering}",
        options=ClaudeOptions(max_turns=5, model="claude-sonnet-4-6")
    )

async def main():
    # Prepare input
    offering = "[shared input data]"

    # Define each thunder god
    thunder_gods = {
        "Performance": "You are a Performance Analyst. Mission: Analyze from a performance perspective...",
        "Security": "You are a Security Guardian. Mission: Review from a security perspective...",
        "Maintainability": "You are a Maintainability Expert. Mission: Evaluate from a maintainability perspective...",
    }

    # Launch all thunders in parallel
    tasks = {
        name: summon_agent(talisman, offering)
        for name, talisman in thunder_gods.items()
    }
    results = {}
    for name, task in zip(tasks.keys(), asyncio.as_completed(tasks.values())):
        results[name] = await task

    # Merger consolidates
    merger_talisman = """
    You are the Grand Arbiter.
    Mission: Synthesize the following multi-angle analyses and make a final decision.
    Decision Rule: Security issues have veto power; others are weighted.
    """
    combined = "\n\n".join(
        f"=== {name} Report ===\n{result}"
        for name, result in results.items()
    )
    final = await Claude.create(
        prompt=f"{merger_talisman}\n\nReports:\n{combined}",
        options=ClaudeOptions(max_turns=5, model="claude-sonnet-4-6")
    )

    print(f"Council complete. Final decision:\n{final}")

asyncio.run(main())
```

### TypeScript SDK Iterative Refinement Template

```typescript
/**
 * Ceremony: Nine-Turn Elixir (Iterative Refinement)
 * Builder and Reviewer alternate until the elixir is complete.
 */
import { Claude, ClaudeOptions } from "claude-code-sdk";

const MAX_TURNS = 3;

async function main() {
  const builderTalisman = `
You are a Builder Master.
Mission: [build/fix task]
`;

  const reviewerTalisman = `
You are a Reviewer.
Mission: Audit the artifact and determine if it passes.
Report Format:
- Verdict: Pass / Fail
- Issue List: [if fail, list all issues]
`;

  let artifact = "";
  let feedback = "First turn, no previous report.";

  for (let turn = 1; turn <= MAX_TURNS; turn++) {
    console.log(`Turn ${turn} refining...`);

    // Builder refines
    artifact = await Claude.create({
      prompt: `${builderTalisman}\n\nTurn ${turn}.\nPrevious report: ${feedback}\nPrevious artifact: ${artifact}`,
      options: { maxTurns: 10, model: "claude-sonnet-4-6" },
    });

    // Reviewer tests
    const review = await Claude.create({
      prompt: `${reviewerTalisman}\n\nArtifact (turn ${turn}):\n${artifact}`,
      options: { maxTurns: 5, model: "claude-sonnet-4-6" },
    });

    if (review.includes("Pass")) {
      console.log(`Turn ${turn} passed!`);
      break;
    }

    feedback = review;
    if (turn === MAX_TURNS) {
      console.log(`Max turns reached. Unresolved report:\n${feedback}`);
    }
  }

  console.log(`Final artifact:\n${artifact}`);
}

main();
```

---

## III. Hooks Integration

Claude Code Hooks execute shell commands in response to specific events. Combine Hooks with the talisman system for automated enhancements.

### Hooks Mapping

| Hook Event | Daoist Equivalent | Usage |
|-----------|-------------------|-------|
| `PreToolUse` | Pre-cast ward | Intercept and check before a tool is used |
| `PostToolUse` | Post-cast verification | Auto-verify results after tool use |
| `Notification` | Alarm bell | Triggered when agent sends a notification |
| `Stop` | Ceremony closing | Triggered when agent completes |

### Common Hook Configurations

**1. Auto-backup output (backup after every file write)**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "cp \"$CLAUDE_FILE_PATH\" \"/tmp/merit-backup/$(date +%s)-$(basename \"$CLAUDE_FILE_PATH\")\" 2>/dev/null || true"
      }
    ]
  }
}
```

**2. Constraint enforcement (block writes to forbidden zones)**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "echo \"$CLAUDE_FILE_PATH\" | grep -qE '^/(etc|prod|deploy)/' && echo 'BLOCK: Forbidden zone, modification not allowed' && exit 1 || exit 0"
      }
    ]
  }
}
```

**3. Auto-test (run tests after every code edit)**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "echo \"$CLAUDE_FILE_PATH\" | grep -qE '\\.(py|js|ts)$' && echo '[REPORT] Auto-test triggered...' && npm test 2>&1 | tail -5 || true"
      }
    ]
  }
}
```

**4. Completion notification (notify when agent finishes)**

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "osascript -e 'display notification \"Agent ceremony complete\" with title \"Daoist Talismans\"' 2>/dev/null || notify-send 'Daoist Talismans' 'Agent ceremony complete' 2>/dev/null || true"
      }
    ]
  }
}
```

### Generating Hooks with Talismans

When generating a talisman, optionally generate suggested hooks configuration. Append to the talisman:

```
Suggested Hooks Configuration:
(Add the following to the hooks field in .claude/settings.json)

PreToolUse:
- [description]: [hook command]

PostToolUse:
- [description]: [hook command]
```
