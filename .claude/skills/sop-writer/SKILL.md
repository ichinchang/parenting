---
name: sop-writer
description: 引導主管把工作流程寫成一頁 SOP（最終可變 SKILL.md）。當用戶說「我想把這流程教給 AI」「寫成 SKILL」「沉澱我的 know-how」「把這變模板」「下次自動」，引導 5 個 section 寫完整 SOP。對應 W5 教材。
---

# SOP Writer — 寫一頁 SOP 助手

W5 教學重點。把腦中 know-how → 一頁 SOP → 最終可變 SKILL.md。

## 何時啟動

用戶說：
- 「我想把這流程教給 AI」
- 「寫成 SKILL」
- 「沉澱我的 know-how」
- 「把這變模板」
- 「下次自動」
- 「不想每次重講一遍」
- 「教 AI 做 X」

## 5 Section 引導

一次問一段，邊填邊 refine：

### 1. Name (skill 名)
> 「給這 SOP 取個短名字，5 個字內。例：`recruit-screening` / `email-cleanup` / `customer-followup`」

### 2. When to use (何時用)
> 「**什麼情境**會用到？3-5 句具體場景。Claude 會用這判斷何時啟動。」
> ⚠️ 重要：寫得越具體 + 越多 trigger keyword 越好

### 3. Steps (步驟)
> 「列出 5-10 個 step。動詞開頭。如果某 step 你會犯錯 / 卡關，加註：『⚠️ 注意 X』」

### 4. Inputs (輸入)
> 「你會給 Claude 什麼？格式？例：URL / 純文字 / 表格 / 截圖描述。」

### 5. Outputs (輸出)
> 「你期待 Claude 給回什麼？格式？例：3 點摘要 / 條列建議 / Email 草稿 / 表格。」

## 組合 + 存檔

5 段收齊後，產出：

```markdown
---
name: {name}
description: {when-to-use 改寫成 1 句 + 加幾個 trigger keyword}
---

# {name}

## When to use
{when-to-use 5 句版}

## Steps
1. ...

## Inputs
- ...

## Outputs
- ...

## Examples
（讓用戶補 1-2 個真實 case）
```

存到 `my-skills/{name}.md`（這 repo 的 `my-skills/` 資料夾）。

問用戶：「現在試一個案例？」如果 yes → 用這 SOP 跑一次給用戶看效果。

## 反模式

- ❌ 一次列完 5 個 question → 主管會 overwhelm。一次一個。
- ❌ Name 用全名（`how-to-screen-resumes-for-junior-roles`）→ 5 字內 SLUG-like (`resume-screen-jr`)
- ❌ Description 寫得太抽象 → Claude 不會啟動。要含具體 trigger word。
- ❌ Steps 寫超過 10 個 → 拆兩個 skill。
