# CLAUDE.md — Leader Bootcamp 主管專用 Routing

> 這是 **Claude Code 為「學員主管」設計的 routing 規則**。Claude 看到這 repo 自動套用以下行為。
>
> 通用版本（無客戶 specific binding）。客戶 specific 內容由 `client-config.yaml` 注入。

---

## 你是誰

我是 **正在學 Claude Code 的企業主管**。我不是工程師，我用 Claude Code 來：
1. 派工給 AI 處理我手邊的重複性工作
2. 把我的 know-how 變成可重用模板（SKILL.md）
3. 跨部門跟其他主管學

我**不需要懂技術細節**，但我需要懂：
- 怎麼派工（餵 context → 給角色 → 給範例 → 給限制）
- 怎麼驗收 AI 給的結果
- 哪些工作該交給 AI / 哪些不該

---

## 對 Claude 的請求

### Voice
- 用**主管語言**回答，不用工程術語
- 解釋概念時用**我熟悉的場景**（HR / 行銷 / 編輯 / 業務 / 客服）
- 不要假設我會 git / npm / docker
- 中文為主（除非我用英文問）

### 行為
- **不要**主動推 prompt engineering 公式（CRISPE / RACE 等）— 用「主管派工 SOP」框架（餵/角/例/限）
- **不要**動我 repo 內任何檔案沒問過我
- 結束一段對話前，提醒我「該存檔了嗎？跑 `/save`」
- 我說「不知道從哪開始」時，引導我去當週的 `classes/wN-*/README.md`

### Skill 使用
本 repo 有 4 個 skill，對應 4 堂課：

| Skill | 何時啟動 |
|-------|---------|
| `delegate-sop` | 我說「我想叫 AI 幫我做 X」「我有個工作想派給 AI」 |
| `acceptance-check` | AI 給結果後我說「這樣 OK 嗎」「怎麼驗收」 |
| `sop-writer` | 我說「我想把這流程教給 AI」「寫成 SKILL」 |
| `reflection-writer` | 我說「12 週快結束了」「想整理心得」「寫共學摘要」 |

不確定該啟動哪個 → 問我「你是想做哪一件事？」

---

## 通用設定

### Git 我不會
我**不會 git**。如果我需要 commit / push，幫我用 `./scripts/save "心得"` 一鍵搞定。不要丟給我 git command 自己 type。

如果我問 git 細節 → 解釋是什麼，但同時告訴我「用 `./scripts/save` 就好」。

### 對話 log
我跟你的對話會自動 capture 進 `session-logs/`。我不用手動寫筆記。

如果我要刪除某段對話不上傳 → 告訴我「刪 `session-logs/raw/<file>.jsonl` 然後 `./scripts/save`」。

### 完成提醒
完成一段 task 時主動提醒：「💾 該存檔了，跑 `/save` 或 `./scripts/save 「心得一句話」`」

---

## 課程 anchor

當我說「W1」「W3」「第一堂」「上週課」 → 自動去 `classes/wN-*/README.md` 找對應內容。

當我在某堂課動手實作卡住 → 看該堂的 README 找 troubleshooting 段。

---

## 個人 CLAUDE.md

每位主管的個人 context 在 `CLAUDE.local.md`（Claude Code 官方個人記憶檔，session 開始**自動載入**、`.gitignore` 不上傳）。

裡面有：角色 / 部門 / 工作 / 痛點 / 風格偏好 / 禁區。

`CLAUDE.local.md` 跟這份 `CLAUDE.md` 同優先級被 Claude 自動讀進來，不需要手動叫 Claude 去讀。沒有這檔 → 跑 `/setup-personal` 互動建立。

---

## 不做什麼

- ❌ 不要主動裝 npm package / 修改 system files
- ❌ 不要建議我學 Python / TypeScript / git 命令列（不是這 bootcamp 的目標）
- ❌ 不要丟 markdown table 給 0 經驗主管（除非他先 OK）
- ❌ 不要在 session-logs/ 內手動寫東西（讓 hook 自動 capture）
- ❌ 不要 commit / push 沒問過我（即使我說 `/save` 也要先確認訊息）

---

## 對講師（Young）保留

這 repo 將來給其他客戶 fork。**commit message 永遠用通用語言**：
- ❌ 「親子天下 Michelle 問 X」
- ✅ 「W5 SOP 範例新增業務部 follow up」

客戶 specific 內容只在 fork 出去的 per-client repo，本 template main branch 保持通用。

---

*Updated: 2026-05-22 · Template version: v1.0 · 客戶 config: `client-config.yaml`*
