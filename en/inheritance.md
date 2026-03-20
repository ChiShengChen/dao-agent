# Template Inheritance ── Lineage System

One lineage, all methods converge. Child talismans inherit shared settings from a parent talisman, overriding only the differences — reducing duplication, unifying conventions.

---

## The Principle

In grand ceremonies, multiple agents often share the same:
- Altar settings (working directory)
- Commandments (universal + ceremony)
- Code style (naming conventions, language)
- Sandbox configuration (allow/deny paths)
- Model configuration (model selection)

Instead of repeating these in every talisman, establish a **Parent Talisman** (Base Talisman) and let each agent's talisman inherit from it as a **Child Talisman**.

---

## Parent Talisman Format

```markdown
# Parent Talisman: [Project Name]

## Altar
- Root: [path]
- Language: [language]
- Framework: [framework]
- Package Manager: [package manager]

## Shared Commandments
Universal:
- UC-001 No secret leakage
- UC-002 No boundary violation: limited to [path] and subdirectories
- UC-003 No fabrication
- UC-005 No error swallowing: errors logged to [log path]

Ceremony:
- CC-001: [project-level constraint]
- CC-002: [project-level constraint]

## Shared Style
- Naming: [camelCase / snake_case / ...]
- Indentation: [spaces / tabs, N]
- Comment language: [Chinese / English]
- Error handling: [pattern description]

## Shared Sandbox
- Allow Read: [glob patterns]
- Allow Write: [glob patterns]
- Deny Access: [glob patterns]

## Shared Model Config
- Default model: [model]
- Default max_turns: [N]

## Shared Enhancements
- [Self-Reflection / Progress Report / ...]
```

---

## Child Talisman Format

Child talismans only write the **differences**; everything else is inherited.

```markdown
# Child Talisman: [Dharma Name]
# Inherits: [Parent Talisman Name]

## Mission
[This agent's specific task — required, cannot inherit]

## Overrides

### Additional Commandments
Role Commandment:
- RC-XXX: [this agent's role commandment]

Additional Ceremony Commandment:
- CC-XXX: [extra constraint]

### Sandbox Extension (expand write scope)
- Additional Write Paths: [extra paths]

### Model Override
- Model: [if this agent needs a different model]
- max_turns: [if this agent needs a different limit]

## Agent-specific Ritual
[This agent's specific steps — not inherited, each agent has its own procedure]

## Agent-specific Merit Ledger
[This agent's output specification — not inherited]
```

---

## Inheritance Rules

| Item | Inheritable | Notes |
|------|------------|-------|
| Altar settings | ✅ Inherit | Shared across all agents |
| Universal commandments | ✅ Inherit | All agents must obey |
| Ceremony commandments | ✅ Inherit + can add | Child can add, cannot remove parent's |
| Style guide | ✅ Inherit | Unified conventions |
| Sandbox | ✅ Inherit + can expand | Child can expand allowed scope, cannot shrink denied scope |
| Model config | ✅ Inherit + can override | Child can select a different model |
| Enhancements | ✅ Inherit + can add | Child can add enhancements, cannot remove parent's |
| Mission | ❌ Not inherited | Each agent has a unique mission |
| Ritual steps | ❌ Not inherited | Each has its own procedure |
| Merit ledger | ❌ Not inherited | Each has its own output spec |

**Core Principle**: Child talismans can **add** or **override**, but cannot **remove** the parent's commandments or constraints (security only increases, never decreases).

---

## Complete Example

### Parent Talisman

```markdown
# Parent Talisman: E-commerce Project

## Altar
- Root: /workspace/ecommerce
- Language: TypeScript
- Framework: Next.js + Prisma
- Package Manager: pnpm

## Shared Commandments
Universal: UC-001, UC-002(/workspace/ecommerce), UC-003, UC-005(/workspace/ecommerce/logs/)
Ceremony:
- CC-001: Do not modify existing migrations under /prisma/migrations/
- CC-002: All API routes must have input validation
- CC-003: Do not install unvetted npm packages

## Shared Style
- Naming: camelCase (variables/functions), PascalCase (types/components)
- Indentation: 2 spaces
- Error handling: Use Result<T, Error> pattern

## Shared Sandbox
- Allow Read: /workspace/ecommerce/**/*
- Allow Write: /workspace/ecommerce/src/**, /workspace/ecommerce/tests/**
- Deny Access: /workspace/ecommerce/.env*, /workspace/ecommerce/node_modules/**

## Shared Model Config
- Default model: claude-sonnet-4-6
- Default max_turns: 10

## Shared Enhancements
- Self-Reflection Spell
- Progress Report Spell
```

### Child Talisman A: Builder

```markdown
# Child Talisman: Shopping Cart Builder
# Inherits: E-commerce Project

## Mission
Implement the add-to-cart feature: POST /api/cart/items

## Overrides

### Additional Ceremony Commandment
- CC-004: Cart logic must have corresponding unit tests

### Sandbox Extension
- Additional Write: /workspace/ecommerce/prisma/schema.prisma

### Model Override
- max_turns: 15 (this task is more complex)

## Agent-specific Ritual
1. Read existing cart-related code, understand the data model
2. Add/modify necessary Prisma schema models
3. Create route handler at /src/app/api/cart/items/
4. Add cart business logic at /src/lib/
5. Write corresponding tests
6. Run pnpm test to confirm all pass

## Agent-specific Merit Ledger
- List of new/modified files
- API endpoint docs (method, path, request/response schema)
- Test coverage report
```

### Child Talisman B: Reviewer

```markdown
# Child Talisman: Shopping Cart Reviewer
# Inherits: E-commerce Project

## Mission
Audit the Shopping Cart Builder's output, ensure quality standards are met.

## Overrides

### Additional Role Commandment
- RC-002: Audit only, do not modify

### Model Override
- Model: claude-opus-4-6 (review needs stronger reasoning)
- max_turns: 5

## Agent-specific Ritual
1. Read the Builder's merit ledger, understand the scope of changes
2. Audit each item:
   - API input validation completeness
   - Error handling using Result pattern
   - Test coverage for normal paths, edge cases, error paths
   - Naming conformance to shared style
   - Compliance with all ceremony commandments
3. Submit inspection report

## Agent-specific Merit Ledger
- Inspection report (standard format)
```

---

## Multi-level Inheritance

Parent talismans can also have parents, forming an inheritance chain. Maximum 3 levels:

```
Grandparent (company-level)
  └→ Parent (project-level)
      └→ Child (agent-level)
```

Beyond 3 levels is overly complex — flatten instead.

---

## Generating Inherited Talismans

When drawing a talisman, if the priest provides project context or shared conventions, automatically:

1. Check if a usable parent talisman already exists
2. If yes, generate child talisman format (differences only)
3. If no, suggest the priest establish a parent talisman first, then generate children
4. Mark "Inherits: [parent name]" in the merit ledger
