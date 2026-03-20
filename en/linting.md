# Talisman Linting ── Prompt Validation Rules

After a talisman is drawn, it must pass through this gate. A broken talisman has no power, a chaotic spell backfires — validation ensures every talisman is structurally complete and unambiguous.

---

## Linting Procedure

After generation, automatically check against the following items. Three severity levels:

### 🔴 Critical (Must Fix — cannot deploy without these)

| # | Check | Criteria | Fix |
|---|-------|----------|-----|
| 1 | **Mission is clear** | Does the talisman have one sentence clearly stating the goal? Can you answer "What does this agent do?" | Add "Mission: [one sentence]" at the top |
| 2 | **Output is defined** | Is the output format and location specified? | Add a "Merit Ledger" section with format and path |
| 3 | **Completion criteria exist** | Is there a clear definition of "done"? How does the agent know it's finished? | Add "Completion Criteria: When [X] and [Y]" |
| 4 | **Constraints exist** | Is there at least one constraint? An unconstrained agent is a wild horse | Add a "Seals" section with at least one prohibition |
| 5 | **No vague instructions** | Are there phrases like "appropriately", "relevant", "reasonable"? | Replace with specifics: "handle errors appropriately" → "on error, log to /tmp/err.log and continue" |

### 🟡 Warning (Should Fix — risks if missing)

| # | Check | Criteria | Fix |
|---|-------|----------|-----|
| 6 | **Error handling** | Are tribulation strategies defined? Cover at least the most likely failures | Add a "Tribulation Strategies" section |
| 7 | **Tool inventory** | Are available and forbidden tools listed? | Add "Tool Inventory" with "May use" and "Forbidden" |
| 8 | **Step-by-step procedure** | Are there numbered steps or a decision tree? | Convert prose instructions to numbered steps |
| 9 | **Context provided** | Is there enough background? Does the agent understand "why"? | Add a "Context" section, one to two sentences |
| 10 | **Examples included** | For strict output formats, is there an input/output example? | Include at least one example |

### 🔵 Info (Nice to Fix — better with these)

| # | Check | Criteria | Fix |
|---|-------|----------|-----|
| 11 | **Token length** | Is it between 300–800 tokens? | Too short: add detail. Too long: trim or split |
| 12 | **Imperative voice** | Are instructions in command form? | "You should read the file" → "Read the file" |
| 13 | **Self-reflection** | Does it include a post-completion self-check? | Append Self-Reflection Spell |
| 14 | **Meditation points** | Are there thinking prompts at critical decisions? | Add Meditation Spell at complex junctions |
| 15 | **Progress reporting** | For multi-step tasks, is there a progress mechanism? | Add Progress Report Spell |

---

## Lint Report Format

After validation, output in this format:

```markdown
# Talisman Lint Report

## Talisman Summary
- Dharma Name: [role name]
- Mission: [one-sentence goal]
- Estimated Length: ~[N] tokens

## Validation Results

| Level | Passed | Failed | Total |
|-------|--------|--------|-------|
| 🔴 Critical | N | N | 5 |
| 🟡 Warning | N | N | 5 |
| 🔵 Info | N | N | 5 |

## Failed Items

### 🔴 Critical
- [ ] #N [Check name]: [specific issue] → [fix suggestion]

### 🟡 Warning
- [ ] #N [Check name]: [specific issue] → [fix suggestion]

### 🔵 Info
- [ ] #N [Check name]: [specific issue] → [fix suggestion]

## Verdict
- ✅ Clear to deploy (all critical passed)
- ⚠️ Deploy with caution (critical passed, warnings remain)
- ❌ Cannot deploy (critical checks failed)
```

---

## Auto-lint Trigger

In the talisman generation flow, automatically run lint after "Step 3: Draw the Talisman". Process:

```
Talisman drawn → Auto-lint → All critical passed?
                                ├─ Yes → Output report + talisman
                                └─ No → Auto-fix → Re-lint (max 3 rounds)
                                                     └─ Still failing → Output report with failures marked + talisman
```

---

## Example: Broken vs. Fixed Talisman

**Broken (fails lint):**
```
You are an assistant. Help me process those files and output the result.
```

**Issues:**
- 🔴 #1 Mission unclear: What does "process" mean?
- 🔴 #2 Output undefined: What format is "the result"? Where does it go?
- 🔴 #3 No completion criteria: How do we know it's done?
- 🔴 #4 No constraints: Nothing is forbidden
- 🔴 #5 Vague instructions: "those files" — which files?

**Fixed:**
```
You are a Data Cleaning specialist.

Mission: Clean all CSV files under /data/raw/ by removing duplicate rows and empty-value rows.

Ritual:
1. List all files matching /data/raw/*.csv
2. For each file: remove fully duplicate rows, remove rows where all columns are empty
3. Store cleaned files in /data/clean/, preserving original filenames

Seals:
- Do not modify the original files in /data/raw/
- Do not change column order or names
- If a file has encoding errors, skip it and log to /data/clean/errors.log

Merit Ledger:
- Cleaned CSVs stored at /data/clean/
- Upon completion, output summary: files processed, rows removed, files skipped

Completion Criteria:
All CSVs processed (or logged as errors), file count in /data/clean/ = original count - error count.
```
