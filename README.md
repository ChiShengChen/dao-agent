# 道法符籙 ── Claude Code Agent Prompt Generator

> [English](README.en.md)

以道教科儀之法，為 Claude Code 生成 agent prompt。

道士書符以敕令天兵；開發者撰 prompt 以驅動 agent。

---

## 功能一覽

| 功能 | 說明 |
|------|------|
| 六大符籙模板 | 獨行道兵、千里眼、造化真人、監察御史、都天大法主、護法天王 |
| 六大基礎科儀 | 步罡踏斗(Pipeline)、五雷正法(Fan-out)、九轉金丹(迭代)、守關法、三清會議、三才陣 |
| 進階科儀 | 巢狀科儀、輪值道兵(Human-in-the-Loop)、替身道兵(Fallback) |
| 符籙庫 | 7 道現成符籙：重構、測試、翻譯、DB遷移、API、CI/CD、安全掃描 |
| 符籙驗證 | 15 條自動檢查規則，三級分類（天劫/地劫/人劫） |
| 法力估算 | Token 預算估算公式與速記口訣 |
| 問診模式 | 互動式引導，自動推薦最適科儀 |
| 科儀圖譜 | ASCII / Mermaid 拓撲圖自動生成 |
| MCP 法器對接 | Slack、GitHub、Database 等 MCP server 整合指引 |
| Agent SDK 科儀 | Python / TypeScript SDK 編排模板 |
| Hooks 連動 | 自動試煉、禁制守護、收壇通報等 hooks 配置 |
| 天條戒律 | 三層戒律體系（天條/職律/壇律）+ 豁免機制 + 違規奏摺 |
| 加持符系統 | 6 道獨立加持（自省/通報/靜心/結界/金剛戒/天眼通）+ 相生相剋表 |
| 功過格 | 召喚記錄、五維度考核評分、科儀總結、月報統計 |
| 演法壇 | Mock 資料乾跑科儀，驗證壇位銜接，支援局部演法 |
| 法會錄 | 科儀結束後自動生成 post-mortem 報告 |
| 傳承譜系 | 母符/子符繼承機制，減少重複，統一門規 |

## 安裝

```bash
# 預設安裝（中文）
bash install.sh

# 選擇語言安裝
bash install.sh --lang zh   # 中文
bash install.sh --lang en   # English
```

安裝腳本會將對應語言的 skill 檔案複製到 `~/.claude/skills/` 目錄。

## 手動安裝

若不使用安裝腳本，將對應語言資料夾中的所有檔案複製到你的 Claude Code skills 目錄：

```bash
# 中文
cp zh/*.md ~/.claude/skills/daoist-agent/

# English
cp en/*.md ~/.claude/skills/daoist-agent/
```

## 使用方式

安裝後，在 Claude Code 中：

```
# 直接描述需求
> 幫我敕令一位道兵去重構 /src/api 下的程式碼

# 使用道教術語
> 開壇，召三位神將，以五雷正法並行翻譯三國語言

# 簡單說
> 幫我寫一個 agent prompt 讓 Claude Code 去做 code review
```

## 檔案結構

```
files_dao/
├── README.md                  ← 中文說明（本檔）
├── README.en.md               ← English README
├── install.sh                 ← 安裝腳本（支援語言選擇）
├── zh/                        ← 中文版（14 檔）
│   ├── SKILL.md               ← Skill 主檔
│   ├── talismans.md           ← 六大符籙模板
│   ├── rituals.md             ← 六大基礎科儀
│   ├── library.md             ← 符籙庫（現成符）
│   ├── linting.md             ← 符籙驗證規則
│   ├── advanced-rituals.md    ← 進階科儀
│   ├── integrations.md        ← 法器對接
│   ├── estimation.md          ← 法力估算
│   ├── commandments.md        ← 天條戒律
│   ├── enhancements.md        ← 加持符系統 + 相生相剋表
│   ├── merit-record.md        ← 功過格
│   ├── simulator.md           ← 演法壇
│   ├── postmortem.md          ← 法會錄
│   └── inheritance.md         ← 傳承譜系
├── en/                        ← English version（14 檔）
│   └── (same structure)
└── daoist-agent.skill         ← 打包檔
```

## 授權

MIT
