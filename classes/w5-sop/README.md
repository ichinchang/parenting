# W5 — SOP 沉澱（簡化版）

> 第三堂課。130 min 午餐。
> **對應 Anthropic 教材**: [Engineering Blog — Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) + 瀏覽 [anthropics/skills](https://github.com/anthropics/skills) repo template

## 共學目標

把自己的 know-how 變 **一頁 SOP 草稿**（不一定要叫 SKILL.md，先有結構就好）。**GitHub / marketplace 安裝下載放 W7**。W5 專注「沉澱」這件事。

## 130 min Agenda

| 時段 | 內容 |
|------|------|
| 0:00-0:10 | Baseline lane |
| 0:10-0:25 | W3 回顧（2 主管分享 Triage + 驗收結果）|
| 0:25-0:50 | 主題講解：SOP 沉澱 + Young crm-skill demo + Agent Skills 概念 |
| 0:50-1:40 | 動手：寫一頁 SOP + Claude 對話 refine |
| 1:40-2:00 | Pair 互看 + 給 1 改進建議 |
| 2:00-2:10 | 收尾 + W7 預習 |

## 一頁 SOP 5 個 Section（核心）

```markdown
---
name: my-skill-name
description: 簡短一句，含 trigger keyword
---

# {SOP 名稱}

## When to use (何時用)
3-5 句具體場景

## Steps (步驟)
1. ...
2. ...

## Inputs (輸入)
- 我會給 Claude 什麼

## Outputs (輸出)
- 我期待 Claude 給回什麼

## Examples
1-2 個真實 case
```

→ 在 Claude 內說「想把這流程教給 AI」會自動啟動 `sop-writer` skill 引導你跑這 5 段。

## 要帶走

- [ ] 一頁 SOP 草稿（純文字，5 section）— 存進 `my-skills/`
- [ ] Anthropic Agent Skills 概念理解（不用懂語法）
- [ ] Pair partner 給的 1 個改進建議

**注意：W5 不要求**會 GitHub / 會寫 frontmatter，那些 W7 才推。

## 主影片 + 中文導讀

🎥 [Latent Space: Boris Cherny on Claude Code](https://www.latent.space/p/claude-code)（英文 podcast，主管預習聽精華 10 min）

**導讀重點**：
- Boris 是 Anthropic Claude Code lead engineer
- Anthropic 內部 80% Claude Code 代碼是 Claude 自己寫的（dogfooding）
- 重點不是個別 prompt，是**把每次 prompt 變成可重用資產**
- 對應主管：你部門哪個 SOP 寫一頁能讓屬下不用問你就跑？

## 必讀

- [Anthropic Engineering Blog — Equipping agents with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)（10 min）

## 選讀

- [Claude Code in Action 課程](https://anthropic.skilljar.com/claude-code-in-action)（含 SKILL.md 實作 module，stretch lane 推）

## 預習作業 → W7

- **必做**: SOP 草稿 → v0.2（用 pair 建議 refine）
- **必做**: 瀏覽 [anthropics/skills](https://github.com/anthropics/skills) repo，**挑 2 個非工程 skill**（pdf / docx / xlsx 等）看 SKILL.md 結構
- **選做**: 在自己部門試用 SOP 1 次
- **Stretch**: 試把 SOP 寫成正式 SKILL.md 格式（含 frontmatter）

## 用得上的指令 / skill

- `sop-writer` skill 自動啟動（你說「想把這變模板」時）
- `acceptance-check` 繼續用（驗收 SOP 跑出的結果）
- `/save "W5 SOP 草稿"`
