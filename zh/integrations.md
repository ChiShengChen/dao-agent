# 法器對接 ── Integrations

將外部法器（MCP Server、Agent SDK、Hooks）納入符籙體系。

---

## 壹、MCP 法器對接

MCP（Model Context Protocol）server 是道兵可調用的外部神通。將 MCP tools 寫入符籙時，遵循以下法則。

### MCP 法器分類

| 法器類型 | MCP Server 範例 | 道法用途 |
|---------|----------------|---------|
| 通靈法器 | Slack MCP | 傳訊、通報、問人 |
| 天眼法器 | GitHub MCP | 讀取 PR、Issue、程式碼 |
| 造化法器 | Filesystem MCP | 讀寫檔案、管理壇場 |
| 查典法器 | Database MCP / Postgres MCP | 查詢資料、驗證 schema |
| 千里傳音 | Fetch MCP | 呼叫外部 API、擷取網頁 |
| 觀星法器 | Sentry MCP / Datadog MCP | 監控、錯誤追蹤 |

### 將 MCP 法器寫入符籙

在符籙的「法器清單」中明確列出 MCP tools：

```
法器清單：
- 內建法器：Read, Edit, Write, Bash, Grep, Glob
- MCP 法器：
  - github: create_pull_request, list_issues, get_pull_request_diff
  - slack: send_message（僅限 #deploy-notifications 頻道）
  - postgres: query（僅限 SELECT，不可 INSERT/UPDATE/DELETE）
- 不可觸碰：
  - slack: 除 #deploy-notifications 外的所有頻道
  - postgres: 任何寫入操作
  - 任何未列出的 MCP tool
```

### MCP 禁制範例

```
MCP 禁制：
- Slack：不得發送 @channel 或 @here
- GitHub：不得 merge PR，只可建立與留言
- Database：查詢必須有 LIMIT，最大 1000 行
- Fetch：不得存取內網地址（10.x.x.x, 192.168.x.x）
```

### 帶 MCP 的完整符籙範例

```
你是一位 PR 巡查千里眼。

天命：掃描 [repo] 中所有 open PR，找出超過 7 天未審查的，通報至 Slack。

法器清單：
- MCP 法器：
  - github: list_pull_requests, get_pull_request
  - slack: send_message（僅限 #code-review 頻道）

科儀：
1. 使用 github.list_pull_requests 取得所有 state=open 的 PR
2. 過濾出 created_at 距今超過 7 天且 review 數為 0 的 PR
3. 對每個符合條件的 PR，使用 github.get_pull_request 取得詳細資訊
4. 整理成清冊後，使用 slack.send_message 發送至 #code-review
5. 訊息格式：
   ```
   🔍 以下 PR 已超過 7 天未審查：
   - #123 [標題] by @author (N 天前)
   - #456 [標題] by @author (N 天前)
   請各位仙友撥冗審閱。
   ```

禁制：
- 不得使用 @channel 或 @here
- 不得在 Slack 訊息中包含程式碼內容
- 若無符合條件的 PR，不發送訊息（靜默圓滿）

圓滿條件：
掃描完成，符合條件的 PR 已通報（或確認無需通報）。
```

---

## 貳、Claude Agent SDK 科儀

使用 Python 或 TypeScript 的 Agent SDK 來編排科儀，適合需要程式化控制流的場景。

### 何時用 SDK 而非 CLI

| 場景 | 用 `claude -p`（飛符） | 用 Agent SDK |
|------|----------------------|-------------|
| 一次性任務 | ✅ | ❌ 殺雞焉用牛刀 |
| 固定 pipeline | ⚠️ 可用 shell 串 | ✅ 更好控制 |
| 動態分支邏輯 | ❌ 難做 | ✅ 正途 |
| 需要持久狀態 | ❌ 無狀態 | ✅ 可管理 |
| 錯誤重試與降級 | ❌ 需手動 | ✅ 程式化 |
| 多 agent 並行 | ⚠️ 背景 job | ✅ async/await |

### Python SDK 科儀模板

```python
"""
醮典：[科儀名稱]
以 Claude Agent SDK 編排多位神將。
"""
import asyncio
from claude_code_sdk import Claude, ClaudeOptions

async def main():
    # ── 壹、定義各神將的符籙 ──
    scout_talisman = """
    你是一位千里眼神將。
    天命：[探查任務]
    功德簿：以 JSON 格式輸出至 stdout
    """

    builder_talisman = """
    你是一位造化真人。
    天命：[建造任務]
    供物：[上壇功德的描述]
    """

    reviewer_talisman = """
    你是一位監察御史。
    天命：[審查任務]
    奏摺格式：[格式定義]
    """

    # ── 貳、步罡踏斗（Pipeline） ──
    # 第一壇：千里眼探查
    scout_result = await Claude.create(
        prompt=scout_talisman,
        options=ClaudeOptions(
            max_turns=5,
            model="claude-sonnet-4-6",
        )
    )

    # 第二壇：造化真人建造（帶入探查結果）
    builder_result = await Claude.create(
        prompt=f"{builder_talisman}\n\n供物（探查結果）：\n{scout_result}",
        options=ClaudeOptions(
            max_turns=10,
            model="claude-sonnet-4-6",
        )
    )

    # 第三壇：監察御史審查
    review_result = await Claude.create(
        prompt=f"{reviewer_talisman}\n\n受審法物：\n{builder_result}",
        options=ClaudeOptions(
            max_turns=5,
            model="claude-sonnet-4-6",
        )
    )

    print(f"科儀圓滿。御史奏摺：\n{review_result}")

asyncio.run(main())
```

### Python SDK 五雷正法（並行）模板

```python
"""
醮典：五雷正法（Fan-out / Fan-in）
多路並行，最終匯總。
"""
import asyncio
from claude_code_sdk import Claude, ClaudeOptions

async def summon_agent(talisman: str, offering: str) -> str:
    """敕令一位神將"""
    return await Claude.create(
        prompt=f"{talisman}\n\n供物：\n{offering}",
        options=ClaudeOptions(max_turns=5, model="claude-sonnet-4-6")
    )

async def main():
    # 供物準備
    offering = "[共同的輸入資料]"

    # 定義各路雷神
    thunder_gods = {
        "效能分析": "你是效能分析仙人。天命：從效能角度分析...",
        "安全審查": "你是安全護法。天命：從安全角度審查...",
        "維護評估": "你是維護仙官。天命：從可維護性角度評估...",
    }

    # 五雷齊發（並行）
    tasks = {
        name: summon_agent(talisman, offering)
        for name, talisman in thunder_gods.items()
    }
    results = {}
    for name, task in zip(tasks.keys(), asyncio.as_completed(tasks.values())):
        results[name] = await task

    # 匯雷真人匯總
    merger_talisman = """
    你是太上法主。
    天命：綜合以下多角度分析，做出最終決策。
    決斷法則：安全問題一票否決，其餘加權評估。
    """
    combined = "\n\n".join(
        f"=== {name} 奏摺 ===\n{result}"
        for name, result in results.items()
    )
    final = await Claude.create(
        prompt=f"{merger_talisman}\n\n各路奏摺：\n{combined}",
        options=ClaudeOptions(max_turns=5, model="claude-sonnet-4-6")
    )

    print(f"三清會議圓滿。最終決策：\n{final}")

asyncio.run(main())
```

### TypeScript SDK 九轉金丹模板

```typescript
/**
 * 醮典：九轉金丹（Iterative Refinement）
 * 造化真人與監察御史交替行法，直到丹成。
 */
import { Claude, ClaudeOptions } from "claude-code-sdk";

const MAX_TURNS = 3;

async function main() {
  const builderTalisman = `
你是一位造化真人。
天命：[建造/修正任務]
`;

  const reviewerTalisman = `
你是一位監察御史。
天命：審查法物，判定丹成或不成。
奏摺格式：
- 判定：丹成 / 不成
- 問題清冊：[若不成，列出所有問題]
`;

  let artifact = "";
  let feedback = "初煉，無前次奏摺。";

  for (let turn = 1; turn <= MAX_TURNS; turn++) {
    console.log(`第 ${turn} 轉煉丹...`);

    // 造化真人煉丹
    artifact = await Claude.create({
      prompt: `${builderTalisman}\n\n第 ${turn} 轉。\n前次奏摺：${feedback}\n前次丹藥：${artifact}`,
      options: { maxTurns: 10, model: "claude-sonnet-4-6" },
    });

    // 監察御史試丹
    const review = await Claude.create({
      prompt: `${reviewerTalisman}\n\n受審丹藥（第 ${turn} 轉）：\n${artifact}`,
      options: { maxTurns: 5, model: "claude-sonnet-4-6" },
    });

    if (review.includes("丹成")) {
      console.log(`第 ${turn} 轉丹成！`);
      break;
    }

    feedback = review;
    if (turn === MAX_TURNS) {
      console.log(`已達最大轉數，取最後一轉之丹。未解奏摺：\n${feedback}`);
    }
  }

  console.log(`最終法物：\n${artifact}`);
}

main();
```

---

## 參、Hooks 連動

Claude Code Hooks 可在特定事件觸發 shell 命令。將 Hooks 與符籙體系結合，實現自動化增益。

### Hooks 與道法對應

| Hook 事件 | 道法對應 | 用途 |
|-----------|---------|------|
| `PreToolUse` | 施法前戒 | 在道兵使用法器前攔截檢查 |
| `PostToolUse` | 施法後驗 | 法器使用後自動驗證結果 |
| `Notification` | 鳴鐘示警 | 道兵發出通知時觸發 |
| `Stop` | 收壇記錄 | 道兵圓滿收壇時觸發 |

### 常用 Hook 配置範例

**壹、功德簿自動備份（每次寫檔後備份）**

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

**貳、禁制守護（攔截對禁區的寫入）**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "echo \"$CLAUDE_FILE_PATH\" | grep -qE '^/(etc|prod|deploy)/' && echo 'BLOCK: 此為禁地，不可修改' && exit 1 || exit 0"
      }
    ]
  }
}
```

**參、自動試煉（每次編輯程式碼後跑測試）**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "echo \"$CLAUDE_FILE_PATH\" | grep -qE '\\.(py|js|ts)$' && echo '[法報] 自動試煉啟動...' && npm test 2>&1 | tail -5 || true"
      }
    ]
  }
}
```

**肆、收壇通報（道兵完成時發送通知）**

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "osascript -e 'display notification \"道兵已收壇圓滿\" with title \"道法符籙\"' 2>/dev/null || notify-send '道法符籙' '道兵已收壇圓滿' 2>/dev/null || true"
      }
    ]
  }
}
```

### 為符籙生成對應 Hooks

在生成符籙時，可一併生成建議的 hooks 配置。在符籙末尾附加：

```
建議 Hooks 配置：
（將以下配置加入 .claude/settings.json 的 hooks 欄位）

PreToolUse:
- [描述]：[hook 命令]

PostToolUse:
- [描述]：[hook 命令]
```
