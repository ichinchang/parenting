---
description: 存檔上傳前先做隱私審查，再一鍵存檔。等同「審查 + ./scripts/save」。
---

# /save — 隱私審查 + 一鍵存檔

> 觸發：使用者打 `/save`，或口語說「幫我存檔」「上傳」「存起來給講師看」。

存檔會把你的「對話摘要」上傳到 GitHub，**講師看得到**。所以上傳前 Claude 一定先帶你做隱私審查。

## 你（Claude）要依序做這 4 步

### 1. 找出「即將上傳」的對話摘要
跑 `git -C . status --porcelain session-logs/*.md` 列出新增 / 修改、會被上傳的 `session-logs/*.md`（這些是人讀的對話摘要；`session-logs/raw/*.jsonl` 是 gitignored 不會上傳，不用看）。
若沒有任何 session-logs md → 直接跑 `./scripts/save "$ARGUMENTS"`，跳過審查（沒東西要審）。

### 2. 隱私掃描
Read 每個即將上傳的 md，標出可能的私密 / 敏感段落：
- 家人 / 健康 / 個人情緒 / 私事
- 真實人名 + 績效 / 薪資 / 1-on-1 / 360 feedback
- 客戶公司名 + 個資（email / 電話 / 訂單含真名）
- 財務絕對數字（營收 / 成本）
逐段引用你覺得敏感的原文（每段 1 行），讓使用者看到「我抓到這些」。

### 3. 問使用者怎麼處理
用白話問（不要技術術語），例如：
「這份對話我看到這幾段可能是私人的：[列出]。要怎麼處理？
 (a) 全部保留照常上傳　(b) 刪掉我標的那幾段再上傳　(c) 哪幾段你自己指定刪　(d) 這份整個不要上傳」
若掃描後沒發現任何敏感內容 → 告知「沒看到明顯私密內容」，直接問「可以上傳了嗎？」

### 4. 依回答處理後才存檔
- 要刪某段 → 直接 Edit 那個 `session-logs/*.md`，移除該段（檔案是純 markdown，可改）
- 整份不要上傳 → 把該 md 移到 `session-logs/raw/`（gitignored）或刪掉，不要 commit
- 確認後 → 跑 `./scripts/save "$ARGUMENTS"`（空訊息用今日日期）

## scripts/save 底層做什麼（whitelist 模式）
1. `git add session-logs/*.md my-skills/ classes/*/notes-*.md`（只加白名單）
2. `git commit` → `git push`（需 clone 設好的 upstream；桌面版 Clone 會自動設）
- **不會上傳**：`CLAUDE.local.md`（個人 context）、`session-logs/raw/*.jsonl`（原始對話）
- 成功印 ✅ + commit hash；失敗 → friendly error（auth / no-upstream / conflict / network）

## 反模式（不要做）
- ❌ 跳過審查直接 `./scripts/save` — 違反 S15 對學員的承諾「存檔前會幫你檢查」
- ❌ 自己判斷「應該沒事」就不問 — 一定要把抓到的段落給使用者看 + 由他決定
- ❌ 改動白名單以外的檔
